require_rel '../base_model'

module Dina
  class Identifier < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :namespace, type: :string
    property :value, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    belongs_to :person, shallow_path: true, class_name: "Person"

    def self.endpoint_path
      "agent-api/"
    end

    def self.table_name
      "identifier"
    end

  end
end
