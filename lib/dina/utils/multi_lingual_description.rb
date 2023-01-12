module Dina
  module MultiLingualDescription

    # Adds or updates a multilingualDescription with a language key
    #
    # @param opts [Hash] the description expessed as { en: "My description" }
    def set_multilingualDescription(opts = {})
      if self.multilingualDescription.nil?
        self.multilingualDescription = opts
      else
        descriptions = multilingualDescription["descriptions"]
        descriptions.delete_if{|o| o["lang"] == opts.keys[0].to_s}
        descriptions << { "lang" => opts.keys[0].to_s, "desc" => opts[opts.keys[0]] }
      end
    end

  end
end
