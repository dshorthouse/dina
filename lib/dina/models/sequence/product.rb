require_rel '../base_model'

module Dina
  class Product < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :name, type: :string
    property :upc, type: :string
    property :type, type: :string
    property :description, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    validates_presence_of :group, message: "group is required"
    validates_presence_of :name, message: "name is required"

    def self.endpoint_path
      "seqdb-api/"
    end

    def self.table_name
      "product"
    end

  end
end
