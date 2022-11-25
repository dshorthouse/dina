require_rel 'base_model'

module Dina
  class Derivative < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :bucket, type: :string
    property :fileIdentifier, type: :string
    property :fileExtension, type: :string
    property :dcType, type: :string
    property :cdFormat, type: :string
    property :acHashFunction, type: :string, default: "SHA-1"
    property :acHashValue, type: :string
    property :derivativeType, type: :string

    belongs_to :object_store, shallow_path: true

    def self.endpoint_path
      "objectstore-api/"
    end

    def self.table_name
      "derivative"
    end

  end
end
