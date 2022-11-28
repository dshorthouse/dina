require_rel 'base_model'

module Dina
  class Person < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :displayName, type: :string, default: nil
    property :givenNames, type: :string
    property :familyNames, type: :string
    property :email, type: :string
    property :webpage, type: :string
    property :remarks, type: :string
    property :aliases, type: :array, default: []
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_many :organizations
    has_many :identifiers

    validates_presence_of :familyNames, message: "familyNames is required"
    validates_presence_of :displayName

    def self.endpoint_path
      "agent-api/"
    end

    def self.table_name
      "person"
    end

    # Finds a Person object using an email address
    #
    # @param email [String] an email address
    # @return Person [Object] a Person object
    def self.find_by_email(email)
      where("email": email).all.first
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
