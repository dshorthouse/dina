require_rel 'base_model'

module Dina
  class ManagedAttribute < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :name, type: :string
    property :key, type: :string
    property :vocabularyElementType, type: :string
    property :managedAttributeComponent, type: :string
    property :acceptedValues, type: :array
    property :multilingualDescription, type: :multilingual_description
    property :createdBy, type: :string
    property :createdOn, type: :time

    validates_presence_of :group, message: "group is required"
    validates_presence_of :name, message: "name is required"
    validates_presence_of :vocabularyElementType, message: "vocabularyElementType is required"

    attr_accessor :accepted_components, :accepted_types

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "managed-attribute"
    end

    def self.accepted_components
      [
        "COLLECTING_EVENT",
        "MATERIAL_SAMPLE",
        "DETERMINATION",
        "ASSEMBLAGE"
      ]
    end

    def self.accepted_types
      [
        "INTEGER",
        "STRING",
        "PICKLIST",
        "DATE",
        "BOOL"
      ]
    end

    private

    def on_before_save
      if !self.managedAttributeComponent.nil? && !self.class.accepted_components.include?(self.managedAttributeComponent)
        raise PropertyValueInvalid, "#{self.class} is invalid. Accepted value for managedAttributeComponent is one of #{self.class.accepted_components.join(", ")}"
      end
      if !self.vocabularyElementType.nil? && !self.class.accepted_types.include?(self.vocabularyElementType)
        raise PropertyValueInvalid, "#{self.class} is invalid. Accepted value for vocabularyElementType is one of #{self.class.accepted_types.join(", ")}"
      end
      super
    end

  end
end
