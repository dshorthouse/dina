require_rel 'base_model'

module Dina
  class Collection < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :name, type: :string
    property :code, type: :string
    property :multilingualDescription, type: :multilingual_description
    property :webpage, type: :string
    property :contact, type: :string
    property :address, type: :string
    property :remarks, type: :string
    property :identifiers, type: :array, default: []
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_one :institution, class_name: "Institution"
    has_one :parent_collection, class_name: "Collection"

    validates_presence_of :group

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "collection"
    end

    def self.find_by_name(name)
      where(name: name).all.first
    end

    def self.find_by_code(code)
      where(code: code).all.first
    end

  end
end
