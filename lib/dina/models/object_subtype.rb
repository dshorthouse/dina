require_rel 'base_model'

module Dina
  class ObjectSubtype < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :createdBy, type: :string
    property :createdOn, type: :time
    property :dcType, type: :string
    property :acSubtype, type: :string

    def self.endpoint_path
      "objectstore-api/"
    end

    def self.table_name
      "object-subtype"
    end
  end
end
