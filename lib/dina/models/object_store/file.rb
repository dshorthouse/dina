module Dina

  class FileConnection
    def initialize(options = {})
      site = options.fetch(:site)
      connection_options = options.slice(:proxy, :ssl, :request, :headers, :params)
      adapter_options = Array(options.fetch(:adapter, Faraday.default_adapter))

      @faraday = Faraday.new(site, connection_options) do |builder|
        builder.request :multipart
        builder.use ::JsonApiClient::Middleware::ParseJson
        builder.adapter(*adapter_options)
      end
      yield(self) if block_given?
    end

    def run(request_method, path, params: nil, headers: {}, body: nil)
      path = path + "/#{body[:data]["attributes"]["group"].downcase}"
      if body[:data]["attributes"].key?("is_derivative")
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

  class File < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :filePath, type: :string
    property :fileName, type: :string
    property :dcFormat, type: :string
    property :is_derivative, type: :boolean

    self.connection_class = FileConnection

    validates_presence_of :group, message: "group is required"
    validates_presence_of :filePath, message: "filePath is required"
    validates_presence_of :fileName, message: "fileName is required"
    validates_presence_of :dcFormat, message: "dcFormat is required"

    def self.endpoint_path
      "objectstore-api/"
    end

    def self.table_name
      "file"
    end

    def self.custom_headers
      { content_type: "multipart/form-data", authorization: Dina.header }
    end

    private

    def on_before_save
      if !self.filePath.nil? && !::File.exist?(self.filePath)
        raise PropertyValueInvalid, "#{self.class} is invalid. File not found in filePath."
      end
      super
    end

  end
end