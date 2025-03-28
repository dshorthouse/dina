require_rel '../base_model'

module Dina
  class FileParser
    class << self
      def parse(klass, response)
        data = response.body.present? ? response.body : {}

        return data if !data.respond_to?(:fetch)

        ::JsonApiClient::ResultSet.new.tap do |result_set|
          result_set.record_class = klass
          result_set.uri = response.env[:url]
          handle_json_api(result_set, data)
          handle_data(result_set, data)
          handle_errors(result_set, data)
          handle_meta(result_set, data)
          handle_links(result_set, data)
          handle_relationships(result_set, data)
          handle_pagination(result_set, data)
          handle_included(result_set, data)
        end
      end

      #
      # Given a resource hash, returns a Resource.new friendly hash
      # which flattens the attributes in w/ id and type.
      #
      # Example:
      #
      # Given:
      #  {
      #    id: 1.
      #    type: 'person',
      #    attributes: {
      #      first_name: 'Jeff',
      #      last_name: 'Ching'
      #    },
      #    links: {...},
      #    relationships: {...}
      #  }
      #
      # Returns:
      #  {
      #    id: 1,
      #    type: 'person',
      #    first_name: 'Jeff',
      #    last_name: 'Ching'
      #    links: {...},
      #    relationships: {...}
      #  }
      #
      #
      def parameters_from_resource(params)
        attrs = params.slice('id', 'links', 'meta', 'type', 'relationships')
        attrs.merge(params.fetch('attributes', {}))
      end

      private

      def handle_json_api(result_set, data)
        result_set.implementation = ::JsonApiClient::Implementation.new(data.fetch("jsonapi", {}))
      end

      def handle_data(result_set, data)
        # all data lives under the "data" attribute
        results = data.fetch("data", [])

        # we will treat everything as an Array
        results = [results] unless results.is_a?(Array)
        resources = results.compact.map do |res|
          resource = result_set.record_class.load(parameters_from_resource(res))
          resource.last_result_set = result_set
          resource
        end
        result_set.concat(resources)
      end

      def handle_errors(result_set, data)
        result_set.errors = ::JsonApiClient::ErrorCollector.new(data.fetch("errors", []))
      end

      def handle_meta(result_set, data)
        result_set.meta = ::JsonApiClient::MetaData.new(data.fetch("meta", {}), result_set.record_class)
      end

      def handle_links(result_set, data)
        result_set.links = ::JsonApiClient::Linking::TopLevelLinks.new(result_set.record_class, data.fetch("links", {}))
      end

      def handle_relationships(result_set, data)
        result_set.relationships = ::JsonApiClient::Relationships::TopLevelRelations.new(result_set.record_class, data.fetch("relationships", {}))
      end

      def handle_pagination(result_set, data)
        result_set.pages = result_set.record_class.paginator.new(result_set, data)
      end

      def handle_included(result_set, data)
        result_set.included = ::JsonApiClient::IncludedData.new(result_set, data.fetch("included", []))
      end
    end
  end
end