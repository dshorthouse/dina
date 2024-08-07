require_rel 'endpoint_connection'

module Dina

  class Endpoint

    def self.material_sample_summary(id:)
      connection = EndpointConnection.new
      #TODO: not sure what the /api/ needs to be included here when already present in Dina.config.endpoint_url
      connection.run(:get, "/api/collection-api/material-sample-summary/" + id)
    end

    def self.resource_name_identifier(name:, type:, group:)
      params = {
        "filter[name][EQ]": name,
        "filter[type][EQ]": type,
        "filter[group][EQ]": group
      }
      connection = EndpointConnection.new
      response = connection.run(:get, "/api/collection-api/resource-name-identifier", params: params)
      response["data"][0]["id"] rescue nil
    end

  end
end