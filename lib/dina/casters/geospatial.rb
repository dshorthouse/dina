module Dina
  class Geospatial
    attr_accessor :type
    attr_accessor :coordinates

    def initialize(opts = {})
      @type = ""
      @coordinates = []
      if opts[:type]
        @type = opts[:type]
      end
      if opts[:coordinates]
        @coordinates = opts[:coordinates]
      end
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end