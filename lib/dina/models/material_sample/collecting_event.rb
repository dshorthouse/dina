require_rel '../base_model'

module Dina
  class CollectingEvent < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :group, type: :string
    property :version, type: :integer
    property :dwcVerbatimCoordinates, type: :string
    property :dwcRecordedBy, type: :string
    property :startEventDateTime, type: :string
    property :endEventDateTime, type: :string
    property :verbatimEventDateTime, type: :string
    property :dwcVerbatimLocality, type: :string
    property :host, type: :string
    property :dwcVerbatimLatitude, type: :string
    property :dwcVerbatimLongitude, type: :string
    property :dwcVerbatimCoordinateSystem, type: :string, default: "decimal degrees"
    property :dwcVerbatimSRS, type: :string, default: "WGS84 (EPSG:4326)"
    property :dwcVerbatimElevation, type: :string
    property :dwcVerbatimDepth, type: :string
    property :dwcFieldNumber, type: :string
    property :dwcRecordNumber, type: :string
    property :otherRecordNumbers, type: :array, default: []
    property :dwcCountry, type: :string
    property :dwcCountryCode, type: :string
    property :dwcStateProvince, type: :string
    property :habitat, type: :string
    property :dwcMinimumElevationInMeters, type: :float
    property :dwcMinimumDepthInMeters, type: :float
    property :dwcMaximumElevationInMeters, type: :float
    property :dwcMaximumDepthInMeters, type: :float
    property :substrate, type: :string
    property :remarks, type: :string
    property :publiclyReleasable, type: :boolean, default: true
    property :notPubliclyReleasableReason, type: :string, default: nil
    property :tags, type: :array, default: []
    property :geographicPlaceNameSource, type: :string
    property :geographicPlaceNameSourceDetail, type: :object, default: {}
    property :managedAttributes, type: :object
    property :geoReferenceAssertions, type: :array, default: []
    property :eventGeom, type: :string
    property :extensionValues, type: :array, default: []
    property :createdBy, type: :string
    property :createdOn, type: :time

    has_many :collectors, class_name: "Person"
    has_many :attachment, class_name: "Attachment"

    validates_presence_of :group, message: "group is required"

    before_save :on_before_save

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "collecting-event"
    end

    private

    def on_before_save
      if self.dwcVerbatimLatitude.nil? && self.dwcVerbatimLongitude.nil?
        self.dwcVerbatimCoordinateSystem = nil
        self.dwcVerbatimSRS = nil
      end
      if self.geographicPlaceNameSource.nil?
        self.geographicPlaceNameSourceDetail = nil
      end
      super
    end

  end
end
