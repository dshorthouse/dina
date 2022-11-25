module Dina
  class Determination
    attr_accessor :verbatimScientificName
    attr_accessor :verbatimDeterminer
    attr_accessor :verbatimDate
    attr_accessor :scientificName
    attr_accessor :transcriberRemarks
    attr_accessor :verbatimRemarks
    attr_accessor :determinationRemarks
    attr_accessor :typeStatus
    attr_accessor :typeStatusEvidence
    attr_accessor :determiner #A known UUID for a Person
    attr_accessor :determinedOn
    attr_accessor :qualifier
    attr_accessor :scientificNameSource
    attr_accessor :scientificNameDetails #in the form { classificationPath: "", classificationRanks: "" }
    attr_accessor :isPrimary
    attr_accessor :isFiledAs
    attr_accessor :managedAttributes

    def initialize
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end

  end
end
