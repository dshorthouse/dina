require_rel '../base_model'

module Dina
  class Derivative < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :bucket, type: :string
    property :fileIdentifier, type: :string
    property :fileExtension, type: :string
    property :dcType, type: :string
    property :dcFormat, type: :string
    property :acHashFunction, type: :string, default: "SHA-1"
    property :acHashValue, type: :string
    property :derivativeType, type: :string

    has_one :ac_derived_from, class_name: "ObjectStore"

    validates_presence_of :bucket, message: "bucket is required"
    validates_presence_of :dcFormat, message: "dcFormat is required"
    validates_presence_of :dcType, message: "dcType is required"
    validates_presence_of :fileIdentifier, message: "fileIdentifier is required"
    validates_presence_of :fileExtension, message: "fileExtension is required"

    def self.endpoint_path
      "objectstore-api/"
    end

    def self.table_name
      "derivative"
    end

    private

    def on_before_save
      if self.as_json_api["relationships"].nil? || !self.as_json_api["relationships"].has_key?("acDerivedFrom")
        raise ObjectInvalid, "#{self.class} is invalid. ac_derived_from relationship is required"
      end
      super
    end

  end
end
