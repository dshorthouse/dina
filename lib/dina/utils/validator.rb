module Dina
  class Validator

    def self.valid_depth_elevation(value:)
      value >= 0 && value <= 15000 && value.to_s.split('.').last.size <= 2
    end

  end
end
