require_rel 'base_search'

module Dina
  class SearchAutocomplete < BaseSearch

    def self.endpoint_path
      "search-api/search-ws/auto-complete"
    end

    # index values: "agent", "material_sample", "object_store"
    # known autocomplete fields:
    #   agent: data.attributes.displayName
    #   material_sample: included.attributes.dwcRecordedBy, included.attributes.verbatimDeterminer
    #   object_store: none
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
