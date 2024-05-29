require_rel '../base_model'

module Dina
  class Organization < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :names, type: :array, default: [{languageCode: "EN", name: nil}, {languageCode: "FR", name: nil}]
    property :aliases, type: :array, default: []
    property :createdBy, type: :string
    property :createdOn, type: :time

    validates :englishName, presence: true, on: :create
    validates :frenchName, presence: true, on: :create

    def self.endpoint_path
      "agent-api/"
    end

    def self.table_name
      "organization"
    end

    def englishName=(name)
      names.delete_if{|o| o[:languageCode] == "EN"}
      names << { languageCode: "EN", name: name }
    end

    def englishName
      names.select{|o| o[:languageCode] == "EN"}.first[:name]
    end

    def frenchName=(name)
      names.delete_if{|o| o[:languageCode] == "FR"}
      names << { languageCode: "FR", name: name }
    end

    def frenchName
      names.select{|o| o[:languageCode] == "FR"}.first[:name]
    end

  end
end
