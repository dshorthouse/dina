require_rel 'base_search'

module Dina
  class SearchMapping < BaseSearch

    def self.endpoint_path
      "search-api/search-ws/mapping"
    end

    # index values: "agent", "material_sample", "object_store"
    def self.execute(index:)
      params = {
        indexName: index_name(index: index)
      }
      super(params.compact)
    end

  end
end
