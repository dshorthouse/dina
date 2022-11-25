require_rel 'base_model'

module Dina
  class ManagedAttribute < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :name, type: :string
    property :key, type: :string
    property :managedAttributeType, type: :string #values = STRING or INTEGER
    property :managedAttributeComponent, type: :string #values = COLLECTING_EVENT, MATERIAL_SAMPLE, or DETERMINATION
    property :acceptedValues, type: :array
    property :multilingualDescription, type: :multilingual_description
    property :createdBy, type: :string
    property :createdOn, type: :time

    validates_presence_of :group

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "managed-attribute"
    end

    def english_description=(desc)
      description[:en] = desc
    end

    def english_description
      description[:en]
    end

    def french_description=(desc)
      description[:fr] = desc
    end

    def french_description
      description[:fr]
    end

  end
end
