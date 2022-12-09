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
    attr_accessor :isPrimary #boolean
    attr_accessor :isFiledAs #boolean
    attr_accessor :managedAttributes #array

    attr_accessor :classification
    attr_accessor :ranks

    def initialize
      @scientificNameDetails = {}
    end

    # Add a materialized classification string to scientificNameDetails
    # Path should use pipes, "|" as separators
    #
    # @param path [String] the classification
    def classification=(path)
      if !path.instance_of?(String)
        raise PropertyValueInvalid, "Classification must be a string with individual items separated by pipes."
      end
      @classification = path
      scientificNameDetails.merge!({ classificationPath: path })
    end

    # Add a materialized ranks string to scientificNameDetails
    # Ranks should use pipes, "|" as separators
    #
    # @param ranks [String] the ranks
    def ranks=(ranks)
      if !ranks.instance_of?(String)
        raise PropertyValueInvalid, "Ranks must be a string with individual items separated by pipes."
      end
      @ranks = ranks
      scientificNameDetails.merge!({ classificationRanks: ranks })
    end

    def determiner=(id)
      raise PropertyValueInvalid, "Determiner must be a UUID." if !id.is_uuid?
      @determiner = id
    end

    # Produce a hash with symbolized keys
    def to_hash
      hash = {}
      remove_instance_variable(:@classification) if @classification
      remove_instance_variable(:@ranks) if @ranks
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash.deep_symbolize_keys
    end

  end
end
