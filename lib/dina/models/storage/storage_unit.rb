require_rel '../base_model'

module Dina
  class StorageUnit < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :group, type: :string
    property :name, type: :string
    property :isGeneric, type: :boolean
    property :barcode, type: :string
    property :storageUnitChildren, type: :array
    property :hierarchy, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_one :storage_unit_type, class_name: "StorageUnitType"
    has_one :parent_storage_unit, class_name: "StorageUnit"

    validates_presence_of :group, message: "group is required"

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "storage-unit"
    end
  end
end
