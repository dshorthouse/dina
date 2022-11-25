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
    attr_accessor :dwcGeodeticDatum #A known UUID for a Person
    attr_accessor :isPrimary
    attr_accessor :dwcGeoreferenceVerificationStatus

    def initialize
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end

  end
end
