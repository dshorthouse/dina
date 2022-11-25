module Dina
  class MultilingualDescription
    attr_accessor :descriptions

    def initialize(opts = {})
      @descriptions = []
      if opts[:descriptions]
        @descriptions = opts[:descriptions]
      end
      if opts[:english]
        self.english_description = opts[:english]
      end
      if opts[:french]
        self.french_description = opts[:french]
      end
    end

    def english_description=(desc)
      descriptions.delete_if{|o| o[:lang] == "en"}
      descriptions << { lang: "en", desc: desc }
    end

    def english_description
      descriptions.select{|o| o[:lang] == "en"}.first[:desc]
    end

    def french_description=(desc)
      descriptions.delete_if{|o| o[:lang] == "fr"}
      descriptions << { lang: "fr", desc: desc }
    end

    def french_description
      descriptions.select{|o| o[:lang] == "fr"}.first[:desc]
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
