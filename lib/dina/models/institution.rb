require_rel 'base_model'

module Dina
  class Institution < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :name, type: :string
    property :multilingualDescription, type: :multilingual_description
    property :webpage, type: :string
    property :address, type: :string
    property :remarks, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_many :collections, class_name: "Collection"

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "institution"
    end

  end
end
