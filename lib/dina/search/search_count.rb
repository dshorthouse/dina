require_rel '../models/base_model'
require_rel 'search_connection'

module Dina
  class SearchCount < BaseModel
    self.connection_class = SearchConnection

    custom_endpoint :execute, on: :collection, request_method: :post

    def self.endpoint_path
      "search-api/search-ws/"
    end

    def self.table_name
      "count"
    end

  end
end