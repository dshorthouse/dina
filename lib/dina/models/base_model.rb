module Dina
  class BaseModel < JsonApiClient::Resource
    include JsonApiClient::Helpers::Callbacks

    self.raise_on_blank_find_param = true
    self.add_defaults_to_changes = true
    self.json_key_format = :camelized_key
    self.paginator = JsonApiClient::Paginating::NestedParamPaginator

    before_create :on_before_create
    before_save :on_before_save

    # Required by json_api_client
    # Set by all child classes
    def self.endpoint_path
    end

    # Required by json_api_client
    def self.site
      raise ConfigItemMissing, "Missing endpoint_url from config. Perhaps Dina.config has not yet been called." unless Dina.config.endpoint_url
      raise PropertyInvalid, "Missing endpoint_path in class." unless !endpoint_path.nil?
      Dina.config.endpoint_url + "/" + endpoint_path.to_s
    end

    # injects keycloak bearer token with all json_api_client calls
    def self.custom_headers
      { content_type: "application/vnd.api+json", authorization: Dina.header }
    end

    # helper method for all child classes to retrieve records by group
    def self.find_by_group(group, page: 1, per: 50)
      self.where("group.groupName": group).page(page).per(per)
    end

    # helper method to retrieve all properties for a class
    def self.properties
      self.schema.instance_values["properties"]
    end

    def initialize(params = {})
      symbolized_params = params.transform_keys(&:to_sym)
      params["id"] = SecureRandom.uuid if !symbolized_params[:id]
      super
      extend_model_methods
    end

    private

    def extend_model_methods
      if self.respond_to?(:multilingualDescription)
        extend MultiLingualDescription
      end
      if self.respond_to?(:multilingualTitle)
        extend MultiLingualTitle
      end
    end

    def on_before_create
      self.attributes.delete_if { |k, v| v.nil? || v == "" || ((v.is_a?(Array) || v.is_a?(Hash)) && v.empty?) }
      self.attributes = self.attributes.deep_symbolize_keys
    end

    def on_before_save
      unknown_attributes = self.attributes.symbolize_keys.keys - self.class.properties.keys - [:type]
      if unknown_attributes.size > 0
        raise ObjectInvalid, "#{self.class} is invalid. #{unknown_attributes.join(", ")} are not accepted properties."
      end
      if !self.valid?
        raise ObjectInvalid, "#{self.class} is invalid. #{self.errors.map(&:message).join("; ")}"
      end
    end

  end
end
