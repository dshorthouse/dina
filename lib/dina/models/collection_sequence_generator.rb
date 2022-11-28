require_rel 'base_model'

module Dina
  class CollectionSequenceGenerator < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :amount, type: :string

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "collection-sequence-generator"
    end

  end
end
