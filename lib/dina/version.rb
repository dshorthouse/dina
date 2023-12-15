module Dina
  class Version

    MAJOR = 1
    MINOR = 3
    PATCH = 4
    BUILD = 0

    def self.version
      [MAJOR, MINOR, PATCH, BUILD].compact.join('.').freeze
    end

  end
end
