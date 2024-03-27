require_rel '../base_model'

module Dina
  class ObjectStore < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :createdBy, type: :string
    property :createdOn, type: :time
    property :group, type: :string
    property :dcFormat, type: :string, default: "image/jpeg"
    property :dcType, type: :string
    property :acSubtype, type: :string
    property :fileIdentifier, type: :string
    property :bucket, type: :string
    property :acCaption, type: :string
    property :acDigitizationDate, type: :string
    property :xmpMetadataDate, type: :time
    property :originalFilename, type: :string
    property :fileExtension, type: :string
    property :acHashFunction, type: :string, default: "SHA-1"
    property :acHashValue, type: :string
    property :xmpRightsUsageTerms, type: :string, default: "Government of Canada Usage Term"
    property :xmpRightsWebStatement, type: :string, default: "https://open.canada.ca/en/open-government-licence-canada"
    property :dcRights, type: :string, default: "© His Majesty The King in Right of Canada, as represented by the Minister of Agriculture and Agri-Food | © Sa Majesté le Roi du chef du Canada, représentée par le ministre de l’Agriculture et de l’Agroalimentaire"
    property :xmpRightsOwner, type: :string, default: "Government of Canada"
    property :publiclyReleasable, type: :boolean, default: true
    property :notPubliclyReleasableReason, type: :string
    property :managedAttributes, type: :hash
    property :acTags, type: :array
    property :orientation, type: :integer
    property :resourceExternalURL, type: :string

    has_one :ac_metadata_creator, class_name: "Person"
    has_one :dc_creator, class_name: "Person"
    has_many :derivatives, class_name: "Derivative"

    validates_presence_of :group, message: "group is required"
    validates_presence_of :bucket, message: "bucket is required"
    validates_presence_of :dcFormat, message: "dcFormat is required"
    validates_presence_of :dcType, message: "dcType is required"
    validates_presence_of :xmpRightsUsageTerms, message: "xmpRightsUsageTerms is required"
    validates_presence_of :dcRights, message: "dcRights is required"

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
      if self.group && self.bucket.nil?
        self.bucket = self.group.downcase
      end
      if !self.dcType.nil? && !self.class.accepted_types.include?(self.dcType)
        raise PropertyValueInvalid, "#{self.class} is invalid. Accepted value for dcType is one of #{self.class.accepted_types.join(", ")}"
      end
      super
    end

  end
end
