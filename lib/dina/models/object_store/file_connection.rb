require_rel '../base_model'

module Dina
  class FileConnection

    def initialize(options = {})
      site = options.fetch(:site)
      connection_options = options.slice(:proxy, :ssl, :request, :headers, :params)
      adapter_options = Array(options.fetch(:adapter, Faraday.default_adapter))

      @faraday = Faraday.new(site, connection_options) do |builder|
        builder.request :multipart
        builder.response :json
        builder.adapter(*adapter_options)
      end
      yield(self) if block_given?
    end

    def run(request_method, path, params: nil, headers: {}, body: nil)
      path = path + "/#{body[:data]["attributes"]["group"].downcase}"
      if body[:data]["attributes"].key?("isDerivative")
        path = path + "/derivative"
      end
      file_path = body[:data]["attributes"]["filePath"]
      mime_type = body[:data]["attributes"]["dcFormat"]
      file_name = body[:data]["attributes"]["fileName"]
      
      body[:file] = Faraday::Multipart::FilePart.new(
        file_path,
        mime_type,
        file_name
      )

      response = @faraday.run_request(request_method, path, body, headers) do |request|
        request.params.update(params) if params
      end
      attributes = response.body.dup
      response.body["meta"] = {}
      response.body["errors"] = []
      response.body["data"] = { 
        "id" => attributes["uuid"],
        "type" => "file",
        "relationships" => {},
        "attributes" => attributes
      }
      response
    end

  end
end