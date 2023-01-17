module Dina
  class GeographicSource
    attr_accessor :sourceUrl
    attr_accessor :customGeographicPlace
    attr_accessor :selectedGeographicPlace
    attr_accessor :higherGeographicPlaces
    attr_accessor :stateProvince
    attr_accessor :country
    attr_accessor :recordedOn

    def initialize
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash.deep_symbolize_keys
    end

  end
end
