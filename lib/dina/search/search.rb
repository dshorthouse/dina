require_rel 'base_search'

module Dina
  class Search < BaseSearch

    def self.endpoint_path
      "search-api/search-ws/search"
    end

    # index values: "agent", "material_sample", "object_store"
    # payload is a hash in the form of an Elasticsearch body
    def self.execute(index:, payload: { query: { match_all: {} } })
      params = {
        indexName: index_name(index: index)
      }
      super(params.compact, method: :post, payload: payload)[:hits]
    end

  end
end
