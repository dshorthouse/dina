require_rel '../base_model'

module Dina
  class Expedition < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :group, type: :string
    property :name, type: :string
    property :multilingualDescription, type: :multilingual_description
    property :startDate, type: :date
    property :endDate, type: :date
    property :geographicContext, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_many :participants, class_name: "Person"

    validates_presence_of :group, message: "group is required"

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "expedition"
    end

  end
end
