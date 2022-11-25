require_rel 'base_model'

module Dina
  class Attachment < BaseModel
    property :id, type: :string, default: SecureRandom.uuid

    belongs_to :material_sample, shallow_path: true
    belongs_to :project, shallow_path: true

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "attachment"
    end

  end
end
