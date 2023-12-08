require_rel '../models/base_model'
require_rel 'search_connection'

module Dina
  class SearchMapping < BaseModel

    self.connection_class = SearchConnection

    custom_endpoint :execute, on: :collection, request_method: :get

    def self.endpoint_path
      "search-api/search-ws/"
    end

    def self.table_name
      "mapping"
    end

  end
end
