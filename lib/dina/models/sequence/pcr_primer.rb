require_rel '../base_model'

module Dina
  class PcrPrimer < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :group, type: :string
    property :type, type: :string
    property :name, type: :string
    property :version, type: :integer
    property :seq, type: :string
    property :position, type: :string
    property :tmCalculated, type: :string
    property :tmPe, type: :integer
    property :application, type: :string
    property :direction, type: :string
    property :reference, type: :string
    property :pooledPrimer, type: :string
    property :lotNumber, type: :string
    property :sequenceLength, type: :integer
    property :targetSpecies, type: :string
    property :supplier, type: :string
    property :dateOrdered, type: :time
    property :dateDestroyed, type: :time
    property :purification, type: :string
    property :designedBy, type: :string
    property :stockConcentration, type: :string
    property :lotNumber, type: :integer
    property :region, type: :string
    property :note, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_one :region

    validates_presence_of :group, message: "group is required"
    validates_presence_of :name, message: "name is required"
    validates_presence_of :type, message: "type is required"
    validates_presence_of :seq, message: "seq is required"
    validates_presence_of :lotNumber, message: "lotNumber is required"

    def self.endpoint_path
      "seqdb-api/"
    end

    def self.table_name
      "pcr-primer"
    end

    def self.accepted_types
      [
        "PRIMER",
        "MID",
        "FUSION_PRIMER",
        "ILLUMINA_INDEX",
        "ITRU_PRIMER"
      ]
    end

    private

    def on_before_save
      if !self.type.nil? && !self.class.accepted_types.include?(self.type)
        raise PropertyValueInvalid, "#{self.class} is invalid. Accepted value for type is one of #{self.class.accepted_types.join(", ")}"
      end
      super
    end

  end
end
