require_rel 'base_search'

module Dina
  class SearchMapping < BaseSearch

    def self.endpoint_path
      "search-api/search-ws/mapping"
    end

    # Return the search mapping document
    #
    # @param index [String] the index, accepted value is one of "agent", "material_sample", "object_store"
    #
    # @return [Hash] the mapping document as a hash with symbolized keys
    def self.execute(index:)
      params = {
        indexName: index_name(index: index)
      }
      super(params.compact)
    end

  end
end
