require_rel 'base_model'

module Dina
  class ObjectStore < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :dcType, type: :string
    property :originalFilename, type: :string
    property :bucket, type: :string
    property :dateTimeDigitized, type: :string
    property :fileIdentifier, type: :string
    property :fileExtension, type: :string
    property :dcFormat, type: :string
    property :dcType, type: :string
    property :acDigitizationDate, type: :time
    property :acCaption, type: :string
    property :xmpMetadataDate, type: :time
    property :xmpRightsWebStatement, type: :string, default: "https://open.canada.ca/en/open-government-licence-canada"
    property :dcRights, type: :string, default: "© Her Majesty The Queen in Right of Canada, as represented by the Minister of Agriculture and Agri-Food | © Sa Majesté la Reine du chef du Canada, représentée par le ministre de l’Agriculture et de l’Agroalimentaire"
    property :xmpRightsOwner, type: :string, default: "Government of Canada"
    property :xmpRightsUsageTerms, type: :string, default: "Government of Canada Usage Term"
    property :orientation, type: :integer
    property :originalFilename, type: :string
    property :acHashFunction, type: :string, default: "SHA-1"
    property :acHashValue, type: :string
    property :acSubtype, type: :string
    property :publiclyReleasable, type: :boolean, default: true
    property :notPubliclyReleasableReason, type: :string
    property :acTags, type: :string
    property :resourceExternalURL, type: :string
    property :managedAttributes, type: :object
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_one :ac_metadata_creator, class_name: "Person"
    has_one :dc_creator, class_name: "Person"
    has_many :derivatives, class_name: "Derivative"

    validates_presence_of :group

    def self.endpoint_path
      "objectstore-api/"
    end

    def self.table_name
      "metadata"
    end

  end
end
