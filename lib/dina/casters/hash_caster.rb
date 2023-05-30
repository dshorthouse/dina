module Dina
  class HashCaster
    def self.cast(value, default)
      if value.is_a?(Hash)
        value
      elsif value.is_a?(Object)
        value.to_h
      else
        default
      end
    end
  end
end
