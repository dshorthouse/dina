module Dina
  class IdentifierType
    attr_accessor :type
    attr_accessor :uri

    def initialize
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end

  end
end
