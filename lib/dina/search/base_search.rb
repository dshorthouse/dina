module Dina
  class BaseSearch < BaseModel

    def self.verify_ssl
      begin
        connection_options[:ssl][:verify]
      rescue
        true
      end
    end

    def self.endpoint
      Dina.config.endpoint_url
    end

    def self.endpoint_path
      "search-api/search-ws/"
    end

    # Sets the search index name
    #
    # @param index [String] the search index; options are "agent", "material_sample", "object_store"
    #
    # @return [String] the internally-recognized search index name
    def self.index_name(index:)
      return nil if !index
      "dina_#{index}_index"
    end

    # Executes a search
    #
    # @param params [Hash] the parameters to be included in the endpoint URL
    # @param method [Symbol] the request type as :get or :post
    # @param payload [Hash] the elasticsearch query
    #
    # @return [Hash] the search response with symbolized keys
    def self.execute(params, method: :get, payload: {})
      begin
        response = RestClient::Request.execute(
          method: method,
          url: endpoint + "/" + endpoint_path + "?" + params.to_query,
          payload: payload.to_json,
          headers: {
            accept: 'application/json',
            content_type: 'application/json',
            authorization: Dina.header
          },
          verify_ssl: verify_ssl
        )
        JSON.parse(response, symbolize_names: true)
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
    end

  end
end
