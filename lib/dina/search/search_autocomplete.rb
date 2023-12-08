require_rel '../models/base_model'
require_rel 'search_connection'

#TODO: requires testing, likely failing

module Dina
  class SearchAutoComplete < BaseModel

    self.connection_class = SearchConnection

    custom_endpoint :execute, on: :collection, request_method: :get

    def self.endpoint_path
      "search-api/search-ws/"
    end

    def self.table_name
      "auto-complete"
    end

  end
end