module Dina
  class ProtocolData
    attr_accessor :key
    attr_accessor :vocabularyBased #boolean
    attr_accessor :protocolDataElement #array

    def initialize
      @protocolDataElement = []
    end

    def add_data_element(data_element)
      if !data_element.instance_of?(ProtocolDataElement)
        raise PropertyValueInvalid, "Data Element must be a ProtocolDataElement."
      end
      @protocolDataElement << data_element.to_hash
    end

    # Produce a hash with symbolized keys
    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash.deep_symbolize_keys
    end

  end
end
