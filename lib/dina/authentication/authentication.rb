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
    #    client_id: "provided by DINA admin in Keycloak",
    #    endpoint_url: "DINA API URL without terminating slash",
    #    authorization_url: "Keycloak authorization URL without terminating slash".
    #    realm: "provided by DINA admin in Keycloak"
    #    verify_ssl: true
    # }
    #
    # @param options [Hash] the configuration options
    def config=(opts = {})
      raise ConfigItemMissing, "Missing token_store_file from config." unless opts[:token_store_file]
      raise ConfigItemMissing, "Missing user from config." unless opts[:user]
      raise ConfigItemMissing, "Missing password from config." unless opts[:password]
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

      if opts.key?(:verify_ssl) && opts[:verify_ssl] == false
        Dina::BaseModel.connection_options[:ssl] = { verify: false }
      end

      if ::File.zero?(config.token_store_file)
        save_token(hash: empty_token)
      end
    end

    # Gets, sets, and renews a Bearer access token as required and produces a Bearer string
    #
    # @return [String] the Bearer token
    def header
      if access_token.nil? || refresh_token.nil?
        get_token
      end

      if Time.now >= Time.parse(auth_expiry)
        renew_token
      end

      "Bearer " + access_token
    end

    # Save default values in token store file
    def flush
      save_token(hash: empty_token)
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
        client_id: nil,
        endpoint_url: nil,
        realm: nil,
        authorization_url: nil
      }
    end

    def access_token
      begin
        token[:access_token]
      rescue
        raise TokenStoreContentInvalid
      end
    end

    def refresh_token
      begin
        token[:refresh_token]
      rescue
        raise TokenStoreContentInvalid
      end
    end

    def auth_expiry
      begin
        token[:auth_expiry]
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
      json = JSON.parse(response, symbolize_names: true)
      save_token(hash: json)
    end

    def renew_token
      begin
        response = Keycloak::Client.get_token_by_refresh_token(
          refresh_token,
          client_id= config.client_id,
          secret='')
        json = JSON.parse(response, symbolize_names: true)
        save_token(hash: json)
      rescue
        get_token
      end
    end

    def token
      @token ||= JSON.parse(::File.read(config.token_store_file), symbolize_names: true)
    end

    def empty_token
      {
        access_token: nil,
        refresh_token: nil,
        expires_in: nil,
        auth_expiry: nil
      }
    end

    def save_token(hash:)
      auth_expiry = (Time.now + hash[:expires_in].seconds).to_s rescue nil
      hash.merge!({ auth_expiry: auth_expiry })
      ::File.write(config.token_store_file, JSON.dump(hash))
      @token = hash
    end

  end

end
