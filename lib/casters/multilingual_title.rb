module Dina
  class MultilingualTitle
    attr_accessor :titles

    def initialize(opts = {})
      @titles = []
      if opts[:titles]
        @descriptions = opts[:titles]
      end
      if opts[:english]
        self.english_title = opts[:english]
      end
      if opts[:french]
        self.french_title = opts[:french]
      end
    end

    def english_title=(title)
      titles.delete_if{|o| o[:lang] == "en"}
      titles << { lang: "en", title: desc }
    end

    def english_title
      titles.select{|o| o[:lang] == "en"}.first[:title]
    end

    def french_title=(title)
      titles.delete_if{|o| o[:lang] == "fr"}
      titles << { lang: "fr", title: title }
    end

    def french_title
      titles.select{|o| o[:lang] == "fr"}.first[:title]
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
