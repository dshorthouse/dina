require_rel '../base_model'

module Dina
  class Region < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string

    validates_presence_of :group, message: "group is required"

    def self.endpoint_path
      "seqdb-api/"
    end

    def self.table_name
      "region"
    end

  end
end
