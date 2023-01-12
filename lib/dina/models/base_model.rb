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

    # Adds or updates a multilingualDescription with a language key
    #
    # @param opts [Hash] the description expessed as { en: "My description" }
    def set_multilingualDescription(opts = {})
      if self.respond_to?(:multilingualDescription)
        if self.multilingualDescription.nil?
          self.multilingualDescription = opts
        else
          descriptions = multilingualDescription["descriptions"]
          descriptions.delete_if{|o| o["lang"] == opts.keys[0].to_s}
          descriptions << { "lang" => opts.keys[0].to_s, "desc" => opts[opts.keys[0]] }
        end
      else
        raise PropertyInvalid, "#{self.class} does not have the property multilingualDescription"
      end
    end

    # Adds or updates a multilingualTitle with a language key
    #
    # @param opts [Hash] the title expessed as { en: "My title" }
    def set_multilingualTitle(opts = {})
      if self.respond_to?(:multilingualTitle)
        if self.multilingualTitle.nil?
          self.multilingualTitle = opts
        else
          titles = multilingualTitle["titles"]
          titles.delete_if{|o| o["lang"] == opts.keys[0].to_s}
          titles << { "lang" => opts.keys[0].to_s, "title" => opts[opts.keys[0]] }
        end
      else
        raise PropertyInvalid, "#{self.class} does not have the property multilingualTitle"
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
