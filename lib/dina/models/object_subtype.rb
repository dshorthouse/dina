require_rel 'base_model'

module Dina
  class ObjectSubtype < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :createdBy, type: :string
    property :createdOn, type: :time
    property :dcType, type: :string
    property :acSubtype, type: :string

    def self.endpoint_path
      "objectstore-api/"
    end

    def self.table_name
      "object-subtype"
    end

    private

    def on_before_save
      if !self.dcType.nil? && !ObjectStore.accepted_types.include?(self.dcType)
        raise PropertyValueInvalid, "#{self.class} is invalid. Accepted value for dcType is one of #{ObjectStore.accepted_types.join(", ")}"
      end
      super
    end

  end
end
