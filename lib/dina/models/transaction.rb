require_rel 'base_model'

module Dina
  class Transaction < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :transactionNumber, type: :string
    property :materialDirection, type: :string
    property :materialToBeReturned, type: :boolean
    property :group, type: :string
    property :transactionType, type: :string
    property :otherIdentifiers, type: :array, default: []
    property :status, type: :string
    property :purpose, type: :string
    property :openedDate, type: :time
    property :closedDate, type: :time
    property :dueDate, type: :time
    property :remarks, type: :string
    property :managedAttributes, type: :object
    property :agentRoles, type: :array
    property :shipment, type: :object
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_many :material_samples, class_name: "MaterialSample"
    has_many :attachment
    has_many :involved_agents, class_name: "Person"

    validates_presence_of :group, message: "group is required"

    def self.endpoint_path
      "loan-transaction/"
    end

    def self.table_name
      "transaction"
    end

  end
end
