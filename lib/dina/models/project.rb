require_rel 'base_model'

module Dina
  class Project < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :name, type: :string
    property :multilingualDescription, type: :multilingual_description
    property :startDate, type: :string
    property :endDate, type: :string
    property :status, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_many :attachment, class_name: "ObjectStore"

    validates_presence_of :group

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "project"
    end

  end
end
