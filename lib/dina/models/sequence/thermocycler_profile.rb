require_rel '../base_model'

module Dina
  class ThermocyclerProfile < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :name, type: :string
    property :application, type: :string
    property :cycles, type: :string
    property :steps, type: :array
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_one :region, class_name: "Region"

    validates_presence_of :group, message: "group is required"
    validates_presence_of :name, message: "name is required"

    def self.endpoint_path
      "seqdb-api/"
    end

    def self.table_name
      "thermocycler-profile"
    end

  end
end
