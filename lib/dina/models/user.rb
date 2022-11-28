require_rel 'base_model'

module Dina
  class User < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :username, type: :string
    property :firstName, type: :string
    property :lastName, type: :string
    property :agentId, type: :string
    property :emailAddress, type: :string
    property :rolesPerGroup, type: :object
    property :createdBy, type: :string
    property :createdOn, type: :time

    validates_presence_of :username, message: "username is required"

    def self.endpoint_path
      "user-api/"
    end

    def self.table_name
      "user"
    end

  end
end
