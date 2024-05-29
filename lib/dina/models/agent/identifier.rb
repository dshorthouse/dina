require_rel '../base_model'

module Dina
  class Identifier < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :namespace, type: :string
    property :value, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    belongs_to :person, class_name: "Person", shallow_path: true

    validates_presence_of :namespace, message: "namespace is required"
    validates_presence_of :value, message: "value is required"

    def self.endpoint_path
      "agent-api/"
    end

    def self.table_name
      "identifier"
    end

  end
end
