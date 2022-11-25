require_rel 'base_model'

module Dina
  class MaterialSample < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :dwcCatalogNumber, type: :string
    property :materialSampleName, type: :string
    property :materialSampleType, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time
    property :barcode, type: :string
    property :group, type: :string
    property :managedAttributes, type: :object
    property :dwcOtherCatalogNumbers, type: :array
    property :preparationMethod, type: :string
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
    property :materialSampleChildren, type: :array
    property :associations, type: :array, default: []
    property :tags, type: :array, default: []
    property :publiclyReleasable, type: :boolean
    property :notPubliclyReleasableReason, type: :string
    property :hostOrganism, type: :object, default: { name: nil, remarks: nil }
    property :scheduledActions, type: :object
    property :hierarchy, type: :object
    property :allowDuplicateName, type: :boolean

    has_one :collection
    has_one :parent_material_sample, class_name: "MaterialSample"
    has_one :collecting_event, class_name: "CollectingEvent"
    has_one :preparation_type
    has_one :prepared_by, class_name: "Person"
    has_one :storage_unit
    has_one :acquisition_event

    has_many :assemblages, class_name: "Assemblage"
    has_many :projects, class_name: "Project"
    has_many :attachment, class_name: "Attachment" #TODO: error requesting Dina::MaterialSample::Metadatum
    has_many :preparation_attachment, class_name: "Attachment" #TODO: error requesting Dina::MaterialSample::Metadatum
    has_many :organism, class_name: "Organism"

    validates_presence_of :group, :materialSampleName

    def self.endpoint_path
      "collection-api/"
    end

    def self.table_name
      "material-sample"
    end

  end
end
