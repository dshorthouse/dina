require_rel '../base_model'

module Dina
  class Person < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :displayName, type: :string, default: nil
    property :givenNames, type: :string
    property :familyNames, type: :string
    property :email, type: :string
    property :webpage, type: :string
    property :remarks, type: :string
    property :aliases, type: :array, default: []
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_many :organizations, class_name: "Organization"
    has_many :identifiers, class_name: "Identifier"

    validates_presence_of :familyNames, message: "familyNames is required"
    validates_presence_of :displayName, message: "displayName is required"

    def self.endpoint_path
      "agent-api/"
    end

    def self.table_name
      "person"
    end

    # Finds a Person object using an email address
    #
    # @param email [String] an email address
    # @return array [Array] an array of Person objects
    def self.find_by_email(email)
      where("email": email).all
    end

    # Searches for a Person by name using the search module
    #
    # @param name [String] any portion of a person's name
    # @return array [Array] an array of Person objects, ordered by relevance
    def self.search_by_name(name)
      payload = {
        query: {
          multi_match: {
            query: name,
            type: :cross_fields,
            fields: [
              "data.attributes.familyNames^3",
              "data.attributes.givenNames",
              "data.attributes.displayName^5",
              "data.attributes.aliases",
              "data.attributes.displayName.autocomplete"
            ]
          }
        }
      }
      hits = Search.execute(index: "agent", payload: payload)[:hits]
      hits.map{|a| self.find(a[:_source][:data][:id]).first }
    end

    private

    def on_before_save
      if self.displayName.nil? || self.displayName == ""
        self.displayName = [familyNames, givenNames].compact.join(", ")
      end
      super
    end

  end
end
