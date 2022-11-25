require_rel 'base_search'

module Dina
  class SearchCount < BaseSearch

    def self.endpoint_path
      "search-api/search-ws/count"
    end

    # index values: "agent", "material_sample", "object_store"
    # Payload is a has like: {query: {bool: {filter: {term: {"data.attributes.group": "dao"}}}}}
    def self.execute(index:, payload: {})
      params = {
        indexName: index_name(index: index)
      }
      super(params.compact, method: :post, payload: payload)[:count]
    end

  end
end
