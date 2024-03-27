require_rel '../base_model'

module Dina
  class CollectionMethod < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :group, type: :string
    property :name, type: :string
    property :multilingualDescription, type: :multilingual_description
    property :createdBy, type: :string
    property :createdOn, type: :time

    belongs_to :collecting_event, class: "CollectingEvent", shallow_path: true

    validates_presence_of :group, message: "group is required"

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "collection-method"
    end

  end
end
