require_relative 'geospatial'

module Dina
  class GeospatialCaster
    def self.cast(value, default)
      begin
        Geospatial.new(value).to_hash
      rescue ArgumentError
        { type: "", coordinates: [] }
      end
    end
  end
end