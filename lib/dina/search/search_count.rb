require_rel 'base_search'

module Dina
  class SearchCount < BaseSearch

    def self.endpoint_path
      "search-api/search-ws/count"
    end

    # Executes an count search
    #
    # @param index [String] the index, accepted value is one of "agent", "material_sample", "object_store"
    # @param payload [Hash] the Elasticsearch query hash
    # => Example: {query: {bool: {filter: {term: {"data.attributes.group": "dao"}}}}}
    #
    # @return [Integer] the count of items in the index according to the query/filter
    def self.execute(index:, payload: {})
      params = {
        indexName: index_name(index: index)
      }
      super(params.compact, method: :post, payload: payload)[:count]
    end

  end
end
