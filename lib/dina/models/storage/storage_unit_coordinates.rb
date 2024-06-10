require_rel '../base_model'

module Dina
  class StorageUnitCoordinates < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :wellRow, type: :string
    property :wellColumn, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_one :storage_unit, class_name: "StorageUnit"

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "storage-unit-coordinates"
    end
  end
end
