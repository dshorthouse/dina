require_rel 'base_model'

module Dina
  class Assemblage < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :name, type: :string
    property :multilingualTitle, type: :multilingual_title
    property :multilingualDescription, type: :multilingual_description
    property :managedAttributes, type: :object
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_many :attachment, class_name: "ObjectStore"

    validates_presence_of :group, :name

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "assemblage"
    end

  end
end