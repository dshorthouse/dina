module Dina
  class Address
    attr_accessor :receiverName
    attr_accessor :companyName
    attr_accessor :addressLine1
    attr_accessor :addressLine2
    attr_accessor :city
    attr_accessor :provinceState
    attr_accessor :zipCode
    attr_accessor :country

    def initialize
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash.deep_symbolize_keys
    end

  end
end
