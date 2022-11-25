require_rel 'base_model'

module Dina
  class Organization < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    #NOTE: should be type: :multilingual_description but API not adjusted
    property :names, type: :array, default: [{languageCode: "EN", name: nil}, {languageCode: "FR", name: nil}]
    property :aliases, type: :array, default: []
    property :createdBy, type: :string
    property :createdOn, type: :time

    validates :english_name, presence: true, on: :create
    validates :french_name, presence: true, on: :create

    def self.endpoint_path
      "agent-api/"
    end

    def self.table_name
      "organization"
    end

    def english_name=(name)
      names.delete_if{|o| o[:languageCode] == "EN"}
      names << { languageCode: "EN", name: name }
    end

    def english_name
      names.select{|o| o[:languageCode] == "EN"}.first[:name]
    end

    def french_name=(name)
      names.delete_if{|o| o[:languageCode] == "FR"}
      names << { languageCode: "FR", name: name }
    end

    def french_name
      names.select{|o| o[:languageCode] == "FR"}.first[:name]
    end

  end
end
