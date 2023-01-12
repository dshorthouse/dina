module Dina
  class MultilingualDescription
    attr_accessor :descriptions

    def initialize(opts = {})
      @descriptions = []
      if opts[:descriptions]
        @descriptions = opts[:descriptions]
      else
        self.set_description(opts)
      end
    end

    def set_description(opts = {})
      opts.each do |key, value|
        descriptions.delete_if{|o| o[:lang] == key.to_s}
        descriptions << { lang: key.to_s, desc: value }
      end
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
