require_rel 'base_model'

module Dina
  class Attachment < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7

    belongs_to :material_sample, shallow_path: true, class_name: "MaterialSample"
    belongs_to :collecting_event, shallow_path: true, class_name: "CollectingEvent"
    belongs_to :project, shallow_path: true, class_name: "Project"
    belongs_to :transaction, shallow_path: true, class_name: "Transaction"

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "attachment"
    end

  end
end
