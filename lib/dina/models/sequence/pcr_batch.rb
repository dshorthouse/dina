require_rel '../base_model'

module Dina
  class PcrBatch < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :group, type: :string
    property :name, type: :string

    validates_presence_of :group, message: "group is required"
    validates_presence_of :name, message: "name is required"

    def self.endpoint_path
      "seqdb-api/"
    end

    def self.table_name
      "pcr-batch"
    end

  end
end
