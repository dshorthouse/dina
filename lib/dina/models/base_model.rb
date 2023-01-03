module Dina
  class BaseModel < JsonApiClient::Resource
    include JsonApiClient::Helpers::Callbacks

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
      Dina.config.endpoint_url + "/" + endpoint_path
    end

    # injects keybloak bearer token with all json_api_client calls
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
    end

    def english_description
      if self.respond_to?(:multilingualDescription)
        multilingualDescription[:descriptions].select{|o| o[:lang] == "en"}.first[:desc]
      end
    end

    def french_description
      if self.respond_to?(:multilingualDescription)
        multilingualDescription[:descriptions].select{|o| o[:lang] == "fr"}.first[:desc]
      end
    end

    private

    def on_before_create
      self.attributes.delete_if { |k, v| v.nil? || v == "" }
      self.attributes = self.attributes.deep_symbolize_keys
    end

    def on_before_save
      if !self.valid?
        raise ObjectInvalid, "#{self.class} is invalid. #{self.errors.map(&:message).join("; ")}"
      end
    end

  end
end
