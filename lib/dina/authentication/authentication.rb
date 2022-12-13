# encoding: utf-8

module Dina
  module Authentication

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
    def self.config(options = {})
      raise ConfigItemMissing, "Missing token_store_file from config." unless options[:token_store_file]
      raise ConfigItemMissing, "Missing user from config." unless options[:user]
      raise ConfigItemMissing, "Missing password from config." unless options[:password]
      raise ConfigItemMissing, "Missing server_name from config." unless options[:server_name]
      raise ConfigItemMissing, "Missing client_id from config." unless options[:client_id]
      raise ConfigItemMissing, "Missing endpoint_url from config." unless options[:endpoint_url]
      raise ConfigItemMissing, "Missing authorization_url from config." unless options[:authorization_url]
      raise ConfigItemMissing, "Missing realm from config." unless options[:realm]

      if !options[:token_store_file].instance_of?(String) || !::File.exist?(options[:token_store_file])
        raise TokenStoreFileNotFound
      end

      @token_store_file = options[:token_store_file]
      @user = options[:user]
      @password = options[:password]
      @server_name = options[:server_name]
      @client_id = options[:client_id]
      @endpoint_url = options[:endpoint_url]
      Keycloak.auth_server_url = options[:authorization_url]
      Keycloak.realm = options[:realm]

      if ::File.zero?(@token_store_file)
        create_empty_token
      end
    end

    # Gets, sets, and renews a Bearer access token as required
    # and produces a Header string
    #
    # @return [String] the Bearer token
    def self.header
      if access_token.nil? || refresh_token.nil?
        set_token
      end

      if Time.now >= Time.parse(auth_expiry)
        renew_token
      end

      "Bearer " + access_token
    end

    class << self
      attr_accessor :endpoint_url

      private

      def access_token
        begin
          read_token[@server_name.to_sym][:access_token]
        rescue
          raise TokenStoreContentInvalid
        end
      end

      def refresh_token
        begin
          read_token[@server_name.to_sym][:refresh_token]
        rescue
          raise TokenStoreContentInvalid
        end
      end

      def auth_expiry
        begin
          read_token[@server_name.to_sym][:auth_expiry]
        rescue
          raise TokenStoreContentInvalid
        end
      end

      def get_token
        response = Keycloak::Client.get_token(
          @user,
          @password,
          client_id= @client_id,
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
            client_id= @client_id,
            secret='')
          json = JSON.parse(response, symbolize_names: true)
          auth_expiry = (Time.now + json[:expires_in].seconds).to_s
          save_token(access_token: json[:access_token], refresh_token: json[:refresh_token], auth_expiry: auth_expiry)
        rescue
          set_token
        end
      end

      def read_token
        JSON.parse(::File.read(@token_store_file), symbolize_names: true)
      end

      def create_empty_token
        data_hash = {}
        data_hash[@server_name.to_sym] = {
          access_token: nil,
          refresh_token: nil,
          auth_expiry: nil
        }
        ::File.write(@token_store_file, JSON.dump(data_hash))
      end

      def save_token(access_token:, refresh_token:, auth_expiry:)
        data_hash = JSON.parse(::File.read(@token_store_file), symbolize_names: true) rescue {}
        data_hash[@server_name.to_sym] = {
          access_token: access_token,
          refresh_token: refresh_token,
          auth_expiry: auth_expiry
        }
        ::File.write(@token_store_file, JSON.dump(data_hash))
      end

    end

  end
end
