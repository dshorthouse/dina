module Dina
  class Version

    MAJOR = 2
    MINOR = 3
    PATCH = 0
    BUILD = 0

    def self.version
      [MAJOR, MINOR, PATCH, BUILD].compact.join('.').freeze
    end

  end
end
