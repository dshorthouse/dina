module Dina
  class BaseModel < JsonApiClient::Resource
    include JsonApiClient::Helpers::Callbacks

    self.json_key_format = :camelized_key
    self.paginator = JsonApiClient::Paginating::NestedParamPaginator

    before_create :on_before_create
    before_save :on_before_save

    def self.endpoint_path
    end

    def self.site
      Dina::Authentication.endpoint_url + "/" + endpoint_path
    end

    def self.custom_headers
      { content_type: "application/vnd.api+json", authorization: Dina::Authentication.header }
    end

    def self.find_by_group(group, page: 1, per: 50)
      self.where("group.groupName": group).page(page).per(per)
    end

    def initialize(params = {})
      params["id"] = SecureRandom.uuid if !params["id"]
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
