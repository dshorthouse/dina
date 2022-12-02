require_rel '../base_model'

module Dina
  class ObjectStore < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :createdBy, type: :string
    property :createdOn, type: :time
    property :group, type: :string
    property :dcFormat, type: :string
    property :dcType, type: :string
    property :acSubtype, type: :string
    property :fileIdentifier, type: :string
    property :bucket, type: :string
    property :acCaption, type: :string
    property :acDigitizationDate, type: :time
    property :xmpMetadataDate, type: :time
    property :originalFilename, type: :string
    property :fileExtension, type: :string
    property :acHashFunction, type: :string, default: "SHA-1"
    property :acHashValue, type: :string
    property :xmpRightsUsageTerms, type: :string, default: "Government of Canada Usage Term"
    property :xmpRightsWebStatement, type: :string, default: "https://open.canada.ca/en/open-government-licence-canada"
    property :dcRights, type: :string, default: "© Her Majesty The Queen in Right of Canada, as represented by the Minister of Agriculture and Agri-Food | © Sa Majesté la Reine du chef du Canada, représentée par le ministre de l’Agriculture et de l’Agroalimentaire"
    property :xmpRightsOwner, type: :string, default: "Government of Canada"
    property :publiclyReleasable, type: :boolean, default: true
    property :notPubliclyReleasableReason, type: :string
    property :managedAttributes, type: :object
    property :acTags, type: :string
    property :orientation, type: :integer
    property :resourceExternalURL, type: :string

    has_one :ac_metadata_creator, class_name: "Person"
    has_one :dc_creator, class_name: "Person"
    has_many :derivatives, class_name: "Derivative"

    validates_presence_of :group, message: "group is required"

    attr_accessor :accepted_types

    def self.endpoint_path
      "objectstore-api/"
    end

    def self.table_name
      "metadata"
    end

    def self.accepted_types
      [
        "IMAGE",
        "MOVING_IMAGE",
        "SOUND",
        "TEXT",
        "DATASET",
        "UNDETERMINED"
      ]
    end

    private

    def on_before_save
      if !self.dcType.nil? && !self.class.accepted_types.include?(self.dcType)
        raise PropertyValueInvalid, "#{self.class} is invalid. Accepted value for dcType is one of #{self.class.accepted_types.join(", ")}"
      end
      super
    end

  end
end
