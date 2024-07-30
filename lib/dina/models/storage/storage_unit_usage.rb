require_rel '../base_model'

module Dina
  class StorageUnitUsage < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :usageType, type: :string
    property :wellRow, type: :string
    property :wellColumn, type: :string
    property :cellNumber, type: :string
    property :storageUnitName, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_one :storage_unit, class_name: "StorageUnit"
    has_one :storage_unit_type, class_name: "StorageUnitType"

    validates_presence_of :usageType, message: "usageType is required"

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "storage-unit-usage"
    end
  end
end
