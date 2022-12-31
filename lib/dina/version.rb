module Dina
  class Version

    MAJOR = 0
    MINOR = 6
    PATCH = 2
    BUILD = 0

    def self.version
      [MAJOR, MINOR, PATCH, BUILD].compact.join('.').freeze
    end

  end
end
