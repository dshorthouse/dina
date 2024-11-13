module Dina
  class GeographicPlaceNameSourceDetail
    attr_accessor :sourceUrl
    attr_accessor :customGeographicPlace
    attr_accessor :selectedGeographicPlace
    attr_accessor :higherGeographicPlaces
    attr_accessor :stateProvince
    attr_accessor :country
    attr_accessor :recordedOn

    def initialize(params = {})
      params.each do |key, value|
        setter = "#{key}="
        send(setter, value) if respond_to?(setter.to_sym, false)
      end
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash.deep_symbolize_keys
    end

  end
end
