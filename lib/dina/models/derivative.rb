require_rel 'base_model'

module Dina
  class Derivative < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :bucket, type: :string
    property :fileIdentifier, type: :string
    property :fileExtension, type: :string
    property :dcType, type: :string
    property :dcFormat, type: :string
    property :acHashFunction, type: :string, default: "SHA-1"
    property :acHashValue, type: :string
    property :derivativeType, type: :string

    belongs_to :ac_derived_from, shallow_path: true, class_name: "ObjectStore"

    validates_presence_of :group, message: "group is required"

    def self.endpoint_path
      "objectstore-api/"
    end

    def self.table_name
      "derivative"
    end

    private

    def on_before_save
      if self.bucket.nil?
        self.bucket = self.group
      end
      super
    end

  end
end
