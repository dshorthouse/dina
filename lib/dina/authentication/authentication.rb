# encoding: utf-8

module Dina
  class Authentication

    class << self
      def instance
        Thread.current[:dina_authentication] ||= new
      end
    end

    def initialize
      @token = nil
      @config = nil
      @opts = default_opts
    end

    def config
      @config ||= OpenStruct.new(@opts)
    end

    # Sets Authentication configuration
    # Options hash as follows:
    # {
    #    token_store_file: "file to store the token",
    #    user: "username provided by DINA admin in Keycloak",
    #    password: "password provided by DINA admin in Keycloak",
    #    server_name: "used locally to reference the token",
    #    client_id: "provided by DINA admin in Keycloak",
    #    endpoint_url: "DINA API URL without terminating slash",
    #    authorization_url: "Keycloak authorization URL without terminating slash".
    #    realm: "provided by DINA admin in Keycloak"
    # }
    #
    # @param options [Hash] the configuration options
    def config=(opts = {})
      raise ConfigItemMissing, "Missing token_store_file from config." unless opts[:token_store_file]
      raise ConfigItemMissing, "Missing user from config." unless opts[:user]
      raise ConfigItemMissing, "Missing password from config." unless opts[:password]
      raise ConfigItemMissing, "Missing server_name from config." unless opts[:server_name]
      raise ConfigItemMissing, "Missing client_id from config." unless opts[:client_id]
      raise ConfigItemMissing, "Missing endpoint_url from config." unless opts[:endpoint_url]
      raise ConfigItemMissing, "Missing authorization_url from config." unless opts[:authorization_url]
      raise ConfigItemMissing, "Missing realm from config." unless opts[:realm]

      if !opts[:token_store_file].instance_of?(String) || !::File.exist?(opts[:token_store_file])
        raise TokenStoreFileNotFound
      end

      @token = nil
      @config = nil
      @opts.merge!(opts)
      Keycloak.auth_server_url = config.authorization_url
      Keycloak.realm = config.realm

      if ::File.zero?(config.token_store_file) || !token.key?(config.server_name.to_sym)
        write_token(data: empty_token)
      end
    end

    # Gets, sets, and renews a Bearer access token as required
    # and produces a Header string
    #
    # WARNING: this is not likely to be threadsafe unless we do away with @token
    # and load the token_store_file with every call to header
    #
    # @return [String] the Bearer token
    def header
      if access_token.nil? || refresh_token.nil?
        set_token
      end

      if Time.now >= Time.parse(auth_expiry)
        renew_token
      end

      "Bearer " + access_token
    end

    # Save default values in token store file
    def flush
      write_token(data: empty_token)
    end

    def flush_config
      @opts = default_opts
      @config = nil
      @token = nil
    end

    private

    def default_opts
      {
        token_store_file: nil,
        user: nil,
        password: nil,
        server_name: nil,
        client_id: nil,
        endpoint_url: nil,
        realm: nil,
        authorization_url: nil
      }
    end

    def access_token
      begin
        token[config.server_name.to_sym][:access_token]
      rescue
        raise TokenStoreContentInvalid
      end
    end

    def refresh_token
      begin
        token[config.server_name.to_sym][:refresh_token]
      rescue
        raise TokenStoreContentInvalid
      end
    end

    def auth_expiry
      begin
        token[config.server_name.to_sym][:auth_expiry]
      rescue
        raise TokenStoreContentInvalid
      end
    end

    def get_token
      response = Keycloak::Client.get_token(
        config.user,
        config.password,
        client_id= config.client_id,
        secret='')
      JSON.parse(response, symbolize_names: true)
    end

    def set_token
      json = get_token
      auth_expiry = (Time.now + json[:expires_in].seconds).to_s
      save_token(access_token: json[:access_token], refresh_token: json[:refresh_token], auth_expiry: auth_expiry)
    end

    def renew_token
      begin
        response = Keycloak::Client.get_token_by_refresh_token(
          refresh_token,
          client_id= config.client_id,
          secret='')
        json = JSON.parse(response, symbolize_names: true)
        auth_expiry = (Time.now + json[:expires_in].seconds).to_s
        save_token(access_token: json[:access_token], refresh_token: json[:refresh_token], auth_expiry: auth_expiry)
      rescue
        set_token
      end
    end

    def token
      @token ||= JSON.parse(::File.read(config.token_store_file), symbolize_names: true)
    end

    def empty_token
      data = {}
      data[config.server_name.to_sym] = {
        access_token: nil,
        refresh_token: nil,
        auth_expiry: nil
      }
      data
    end

    def save_token(access_token:, refresh_token:, auth_expiry:)
      data = JSON.parse(::File.read(config.token_store_file), symbolize_names: true) rescue {}
      data[config.server_name.to_sym] = {
        access_token: access_token,
        refresh_token: refresh_token,
        auth_expiry: auth_expiry
      }
      write_token(data: data)
    end

    def write_token(data:)
      ::File.write(config.token_store_file, JSON.dump(data))
      @token = data
    end

  end

end
