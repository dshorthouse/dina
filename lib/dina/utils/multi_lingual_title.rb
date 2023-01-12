module Dina
  module MultiLingualTitle

    # Adds or updates a multilingualTitle with a language key
    #
    # @param opts [Hash] the title expessed as { en: "My title" }
    def set_multilingualTitle(opts = {})
      if self.multilingualTitle.nil?
        self.multilingualTitle = opts
      else
        titles = multilingualTitle["titles"]
        titles.delete_if{|o| o["lang"] == opts.keys[0].to_s}
        titles << { "lang" => opts.keys[0].to_s, "title" => opts[opts.keys[0]] }
      end
    end

  end
end
