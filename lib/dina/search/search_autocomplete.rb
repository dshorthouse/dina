require_rel 'base_search'

module Dina
  class SearchAutocomplete < BaseSearch

    def self.endpoint_path
      "search-api/search-ws/auto-complete"
    end

    # Executes an autocomplete search
    #
    # Known field values (dependent on chosen index):
    #   agent: data.attributes.displayName
    #   material_sample: included.attributes.dwcRecordedBy, included.attributes.verbatimDeterminer
    #   object_store: none
    #
    # @param term [String] the search term
    # @param index [String] the index, accepted value is one of "agent", "material_sample", "object_store"
    # @param field [String]
    # @param group [String] the DINA group name
    #
    # @return [Hash] the search result with symbolized keys
    def self.execute(term:, index:, field: nil, group: nil)
      params = {
        prefix: term,
        indexName: index_name(index: index),
        autoCompleteField: field,
        group: group
      }
      super(params.compact)[:hits]
    end

  end
end
