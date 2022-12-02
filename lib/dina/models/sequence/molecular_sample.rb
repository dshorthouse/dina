require_rel '../base_model'

module Dina
  class MolecularSample < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string

    validates_presence_of :group, message: "group is required"

    def self.endpoint_path
      "seqdb-api/"
    end

    def self.table_name
      "molecular-sample"
    end

  end
end
