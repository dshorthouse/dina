require_rel '../models/base_model'

module Dina

  class SearchConnection

    attr_reader :faraday

    def initialize(options = {})
      site = options.fetch(:site)
      connection_options = options.slice(:proxy, :ssl, :request, :headers, :params)
      adapter_options = Array(options.fetch(:adapter, Faraday.default_adapter))

      @faraday = Faraday.new(site, connection_options) do |builder|
        builder.request :json
        builder.use ::JsonApiClient::Middleware::ParseJson
        builder.adapter(*adapter_options)
      end
      yield(self) if block_given?
    end

    # Sets the search index name
    #
    # @param index [String] the search index; options are "agent", "material_sample", "object_store"
    #
    # @return [String] the internally-recognized search index name
    def index_name(index:)
      return nil if !index
      "dina_#{index}_index"
    end

    def custom_headers
      { content_type: "application/json", authorization: Dina.header }
    end

    def run(request_method, path, params: nil, headers: {}, body: nil)
      #TODO: works for search class, but likely failing for autocomplete, count, and mapping
      params = {
        indexName: index_name(index: body[:index])
      }
      path.slice!("/execute")
      payload = JSON.generate(body[:payload]) rescue ""

      response = faraday.run_request(request_method, path, body, headers) do |request|
        request.params.update(params) if params
        request.headers = custom_headers
        request.body = payload
      end

      attributes = response.body.dup
      response.body["meta"] = {}
      response.body["errors"] = []
      response.body["data"] = attributes["hits"]["hits"].map{|d| d["_source"]["data"]} rescue []
      response
    end

    def use(middleware, *args, &block)
      return if faraday.builder.locked?
      faraday.builder.insert_before(Middleware::ParseJson, middleware, *args, &block)
    end

  end

end