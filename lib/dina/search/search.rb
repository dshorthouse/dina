require_rel 'base_search'

module Dina
  class Search < BaseSearch

    def self.endpoint_path
      "search-api/search-ws/search"
    end

    # Executes a search
    #
    # @param index [String] the index, accepted value is one of "agent", "material_sample", "object_store"
    # @param payload [Hash] the payload hash as an Elasticsearch-formatted body
    # => { query: { match_all: {} }
    #
    # @return [Hash] the search result with symbolized keys
    def self.execute(index:, payload: { query: { match_all: {} } })
      params = {
        indexName: index_name(index: index)
      }
      super(params.compact, method: :post, payload: payload)[:hits]
    end

  end
end
