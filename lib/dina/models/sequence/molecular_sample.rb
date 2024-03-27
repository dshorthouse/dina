require_rel '../base_model'

module Dina
  class MolecularSample < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :group, type: :string
    property :name, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_one :kit, class_name: "Product"
    has_one :materialSample, class_name: "MaterialSample"

    validates_presence_of :group, message: "group is required"
    validates_presence_of :name, message: "name is required"

    def self.endpoint_path
      "seqdb-api/"
    end

    def self.table_name
      "molecular-sample"
    end

    def self.sample_type
      [
        "DNA"
      ]
    end

    private

    def on_before_save
      if !self.sampleType.nil? && !self.class.sample_type.include?(self.type)
        raise PropertyValueInvalid, "#{self.class} is invalid. Accepted value for sampleType is one of #{self.class.sample_type.join(", ")}"
      end
      super
    end

  end
end
