require_rel 'base_model'

module Dina
  class StorageUnitType < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :name, type: :string
    property :isInseperable, type: :boolean
    property :createdBy, type: :string
    property :createdOn, type: :time

    validates_presence_of :group

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "storage-unit-type"
    end
  end
end
