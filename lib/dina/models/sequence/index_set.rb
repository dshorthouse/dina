require_rel '../base_model'

module Dina
  class IndexSet < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :name, type: :string
    property :forwardAdapter, type: :string
    property :reverseAdapter, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    validates_presence_of :group, message: "group is required"
    validates_presence_of :name, message: "name is required"

    def self.endpoint_path
      "seqdb-api/"
    end

    def self.table_name
      "index-set"
    end

  end
end
