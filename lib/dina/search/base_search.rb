module Dina
  class BaseSearch

    def self.endpoint
      Settings.server.endpoint
    end

    def self.endpoint_path
      "search-api/search-ws/"
    end

    def self.index_name(index:)
      return nil if !index
      "dina_#{index}_index"
    end

    def self.execute(params, method: :get, payload: {})
      begin
        response = RestClient::Request.execute(
            method: method,
            url: endpoint + endpoint_path + "?" + params.to_query,
            payload: payload.to_json,
            headers: { accept: 'application/json', content_type: 'application/json' }
          )
        JSON.parse(response, symbolize_names: true)
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
    end

  end
end
