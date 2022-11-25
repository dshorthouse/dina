
module Dina
  class ArrayCaster
    def self.cast(value, default)
      if value.is_a?(String)
        [value]
      elsif value.is_a?(Array)
        value
      else
        default
      end
    end
  end
end
