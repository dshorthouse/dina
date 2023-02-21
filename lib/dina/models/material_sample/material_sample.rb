require_rel '../base_model'

module Dina
  class MaterialSample < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :version, type: :integer
    property :dwcCatalogNumber, type: :string
    property :materialSampleName, type: :string
    property :materialSampleType, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time
    property :barcode, type: :string
    property :group, type: :string
    property :managedAttributes, type: :object
    property :dwcOtherCatalogNumbers, type: :array
    property :preservationType, type: :string
    property :preparationFixative, type: :string
    property :preparationMaterials, type: :string
    property :preparationSubstrate, type: :string
    property :preparationDate, type: :time
    property :preparationRemarks, type: :string
    property :dwcDegreeOfEstablishment, type: :string
    property :materialSampleState, type: :string
    property :stateChangedOn, type: :time
    property :stateChangeRemarks, type: :string
    property :materialSampleRemarks, type: :string
    property :extensionValues, type: :object
    property :restrictionFieldsExtension, type: :object
    property :restrictionRemarks, type: :string
    property :isRestricted, type: :boolean
    property :materialSampleChildren, type: :array
    property :associations, type: :array, default: []
    property :tags, type: :array, default: []
    property :publiclyReleasable, type: :boolean, default: true
    property :notPubliclyReleasableReason, type: :string
    property :hostOrganism, type: :object, default: { name: nil, remarks: nil }
    property :scheduledActions, type: :object
    property :hierarchy, type: :object
    property :allowDuplicateName, type: :boolean

    has_one :collection, class_name: "Collection"
    has_one :collecting_event, class_name: "CollectingEvent"
    has_one :preparation_type, class_name: "PreparationType"
    has_one :preparation_method, class_name: "PreparationMethod"
    has_one :parent_material_sample, class_name: "MaterialSample"
    has_one :preparation_protocol, class_name: "Protocol"
    has_one :acquisition_event, class_name: "AcquisitionEvent"
    has_one :storage_unit, class_name: "StorageUnit"
    has_many :prepared_by, class_name: "Person"
    has_many :attachment, class_name: "Attachment"
    has_many :projects, class_name: "Project"
    has_many :assemblages, class_name: "Assemblage"
    has_many :organism, class_name: "Organism"

    validates_presence_of :group, message: "group is required"
    validates_presence_of :materialSampleName, message: "materialSampleName is required"
    validates_presence_of :materialSampleType, message: "materialSampleType is required"

    attr_accessor :accepted_types

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "material-sample"
    end

    def self.accepted_types
      [
        "WHOLE_ORGANISM",
        "CULTURE_STRAIN",
        "ORGANISM_PART",
        "MIXED_ORGANISMS",
        "MOLECULAR_SAMPLE"
      ]
    end

    private

    def on_before_save
      if !self.materialSampleType.nil? && !self.class.accepted_types.include?(self.materialSampleType)
        raise PropertyValueInvalid, "#{self.class} is invalid. Accepted value for materialSampleType is one of #{self.class.accepted_types.join(", ")}"
      end
      super
    end

  end
end
