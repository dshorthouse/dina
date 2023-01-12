module Dina
  class MultilingualTitle
    attr_accessor :titles

    def initialize(opts = {})
      @titles = []
      if opts[:titles]
        @titles = opts[:titles]
      else
        self.set_title(opts)
      end
    end

    def set_title(opts ={})
      opts.each do |key, value|
        titles.delete_if{|o| o[:lang] == key.to_s}
        titles << { lang: key.to_s, title: value }
      end
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
