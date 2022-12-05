# Monkeypatch the data method because the relations urls in the DINA JSON:API spec are incorrectly formed through its frontend proxy
module JsonApiClient
  module Associations
    class BaseAssociation
      def data(url)
        url.sub!("/api/v1/", "/api/#{klass.endpoint_path}")
        from_result_set(association_class.requestor.linked(url))
      end
    end
  end
end
