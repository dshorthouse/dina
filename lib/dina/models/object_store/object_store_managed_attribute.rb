require_rel '../base_model'

module Dina
  class ObjectStoreManagedAttribute < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :name, type: :string
    property :key, type: :string
    property :managedAttributeType, type: :string
    property :acceptedValues, type: :array
    property :multilingualDescription, type: :multilingual_description
    property :createdBy, type: :string
    property :createdOn, type: :time

    def self.endpoint_path
      "objectstore-api/"
    end

    def self.table_name
      "managed-attribute"
    end

    private

    def on_before_save
      if !self.managedAttributeType.nil? && !ManagedAttribute.accepted_types.include?(self.managedAttributeType)
        raise PropertyValueInvalid, "#{self.class} is invalid. Accepted value for managedAttributeType is one of #{ManagedAttribute.accepted_types.join(", ")}"
      end
      super
    end

  end
end
