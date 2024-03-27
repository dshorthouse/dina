require_rel '../base_model'

module Dina
  class Collection < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
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

    belongs_to :institution, shallow_path: true, class_name: "Institution"
    has_one :parent_collection, class_name: "Collection"

    validates_presence_of :group, message: "group is required"

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "collection"
    end

    # Finds a Collection object by name
    #
    # @param email [String] a name
    # @return object [Object] a Collection object
    def self.find_by_name(name)
      where(name: name).all
    end

    # Finds a Collection object by code
    #
    # @param code [String] a code
    # @return object [Object] a Collection object
    def self.find_by_code(code)
      where(code: code).all
    end

  end
end
