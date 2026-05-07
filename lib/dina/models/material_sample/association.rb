require_rel '../base_model'

module Dina
  class Association < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :associationType, type: :string
    property :remarks, type: :string

    has_one :sample, class_name: "MaterialSample"
    has_one :associatedSample, class_name: "MaterialSample"

    validates_presence_of :group, message: "group is required"

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "association"
    end

  end
end
