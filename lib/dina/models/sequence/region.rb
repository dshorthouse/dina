require_rel '../base_model'

module Dina
  class Region < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :group, type: :string
    property :name, type: :string
    property :symbol, type: :string
    property :description, type: :string
    property :aliases, type: :string
    property :applicableOrganisms, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    validates_presence_of :group, message: "group is required"
    validates_presence_of :symbol, message: "symbol is required"

    def self.endpoint_path
      "seqdb-api/"
    end

    def self.table_name
      "region"
    end

  end
end
