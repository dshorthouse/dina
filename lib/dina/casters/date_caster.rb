module Dina
  class DateCaster
    def self.cast(value, default)
      if value.is_a?(String)
        y, m, d = value.split '-'
        raise PropertyValueInvalid, "Invalid date" unless Date.valid_date?(y.to_i, m.to_i, d.to_i)
        Date.parse(value).to_s
      elsif value.is_a?(Date)
        value.to_s
      else
        default
      end
    end
  end
end
