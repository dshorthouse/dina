module Dina
  class GeoreferenceAssertion
    attr_accessor :dwcDecimalLatitude
    attr_accessor :dwcDecimalLongitude
    attr_accessor :dwcCoordinateUncertaintyInMeters
    attr_accessor :dwcGeoreferencedDate
    attr_accessor :georeferencedBy
    attr_accessor :literalGeoreferencedBy
    attr_accessor :dwcGeoreferenceProtocol
    attr_accessor :dwcGeoreferenceSources
    attr_accessor :dwcGeoreferenceRemarks
    attr_accessor :dwcGeodeticDatum
    attr_accessor :isPrimary
    attr_accessor :dwcGeoreferenceVerificationStatus
    attr_accessor :createdOn

    def initialize
      @georeferencedBy = []
    end

    # Add a georeferencedBy as UUID to the array
    #
    # @param id [String] a UUID for a georeferencedBy
    def add_georeferencedBy(id:)
      raise PropertyValueInvalid, "georeferencedBy must be a UUID." if !id.is_uuid?
      @georeferencedBy << id
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash.deep_symbolize_keys
    end

  end
end
