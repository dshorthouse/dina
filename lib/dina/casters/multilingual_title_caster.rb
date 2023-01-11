require_relative 'multilingual_title'

module Dina
  class MultilingualTitleCaster
    def self.cast(value, default)
      begin
        MultilingualTitle.new(value).to_hash
      rescue ArgumentError
        { titles: [] }
      end
    end
  end
end
