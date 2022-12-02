require_rel '../base_model'

module Dina
  class Protocol < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :name, type: :string
    property :multilingualDescription, type: :multilingual_description
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_many :attachment, class_name: "Attachment"

    validates_presence_of :group, message: "group is required"

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "protocol"
    end

  end
end
