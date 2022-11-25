require_rel 'base_model'

module Dina
  class ObjectSubtype < BaseModel
    property :id, type: :string, default: SecureRandom.uuid

    def self.endpoint_path
      "objectstore-api/"
    end

    def self.table_name
      "object-subtype"
    end
  end
end
