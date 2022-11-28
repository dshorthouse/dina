require_rel 'base_model'

module Dina
  class AcquisitionEvent < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :receivedDate, type: :string
    property :receptionRemarks, type: :string
    property :isolatedOn, type: :string
    property :isolationRemarks, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    validates_presence_of :group, message: "group is required"

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "acquisition-event"
    end
  end
end
