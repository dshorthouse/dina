require_rel 'base_model'

module Dina
  class Attachment < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7

    belongs_to :materialSample, class_name: "MaterialSample", shallow_path: true 
    belongs_to :collectingEvent, class_name: "CollectingEvent", shallow_path: true
    belongs_to :project, class_name: "Project", shallow_path: true
    belongs_to :transaction, class_name: "Transaction", shallow_path: true

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "attachment"
    end

  end
end
