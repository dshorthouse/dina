module Dina
    class GeographicThesaurus
      attr_accessor :source
      attr_accessor :subjectId
      attr_accessor :preferredTerm
      attr_accessor :preferredParent
      attr_accessor :additionalParents
  
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
  