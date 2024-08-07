module Dina

  class EndpointConnection

    attr_reader :faraday

    def initialize(options = {})
      connection_options = options.slice(:proxy, :ssl, :request, :headers, :params)
      adapter_options = Array(options.fetch(:adapter, Faraday.default_adapter))

      @faraday = Faraday.new(Dina.config.endpoint_url, connection_options) do |builder|
        builder.request :json
        builder.response :json
        builder.adapter(*adapter_options)
      end
      yield(self) if block_given?
    end

    def custom_headers
      { content_type: "application/json", authorization: Dina.header }
    end

    def run(request_method, path, params: nil, headers: {}, body: nil)
      response = faraday.run_request(request_method, path, body, headers) do |request|
        request.params.update(params) if params
        request.headers = custom_headers
      end
      response.body
    end

    def use(*args); end

  end

end