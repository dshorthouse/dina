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
    #    endpoint_url: "DINA API URL",
    #    authorization_url: "Keycloak authorization URL".
    #    realm: "provided by DINA admin in Keycloak"
    # }
    #
    # @param options [Hash] the configuration options
    def self.config(options = {})
      @token_store_file = options[:token_store_file]
      @user = options[:user]
      @password = options[:password]
      @server_name = options[:server_name]
      @client_id = options[:client_id]
      @endpoint_url = options[:endpoint_url]
      @authorization_url = options[:authorization_url]
      @realm = options[:realm]
      Keycloak.auth_server_url = @authorization_url
      Keycloak.realm = @realm
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
      attr_accessor :token_store_file, :authorization_url, :endpoint_url, :client_id, :realm, :server_name

      private

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

      def access_token
        read_token[:access_token]
      end

      def refresh_token
        read_token[:refresh_token]
      end

      def auth_expiry
        read_token[:auth_expiry] rescue "9999-01-01 00:00:00 -0500"
      end

      def read_token
        raise TokenStoreFileNotFound unless @token_store_file.instance_of?(String) && ::File.exist?(@token_store_file)
        JSON.parse(::File.read(@token_store_file), symbolize_names: true)[@server_name.to_sym] rescue default_token
      end

      def default_token
        { access_token: nil, refresh_token: nil, auth_expiry: "9999-01-01 00:00:00 -0500" }
      end

      def save_token(access_token:, refresh_token:, auth_expiry:)
        raise TokenStoreFileNotFound unless @token_store_file.instance_of?(String) && ::File.exist?(@token_store_file)
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
