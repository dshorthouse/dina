module Dina
  class Version

    MAJOR = 3
    MINOR = 0
    PATCH = 0
    BUILD = 0

    def self.version
      [MAJOR, MINOR, PATCH, BUILD].compact.join('.').freeze
    end

  end
end
