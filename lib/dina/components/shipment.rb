module Dina
  class Shipment
    attr_accessor :contentRemarks
    attr_accessor :value
    attr_accessor :currency
    attr_accessor :itemCount
    attr_accessor :shippedOn
    attr_accessor :status
    attr_accessor :packingMethod
    attr_accessor :trackingNumber
    attr_accessor :shipmentRemarks
    attr_accessor :address # with properties receiverName, companyName, addressLine1, addressLine2, city, provinceState, zipCode, country

    def initialize
      @address = {}
    end

    def add_address(address)
      if !address.instance_of?(Hash)
        raise PropertyValueInvalid, "Address must be a Hash."
      end
      @address.merge!(address)
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash.deep_symbolize_keys
    end

  end
end
