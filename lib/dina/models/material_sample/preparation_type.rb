require_rel '../base_model'

module Dina
  class PreparationType < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :group, type: :string
    property :name, type: :string
    property :multilingualDescription, type: :multilingual_description
    property :createdBy, type: :string
    property :createdOn, type: :time

    validates_presence_of :group, message: "group is required"

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "preparation-type"
    end

  end
end
