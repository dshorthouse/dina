module Dina
  class ObjectCaster
    def self.cast(value, default)
      if value.is_a?(Hash)
        value
      else
        default
      end
    end
  end
end
