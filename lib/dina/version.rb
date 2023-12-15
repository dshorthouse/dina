module Dina
  class Version

    MAJOR = 1
    MINOR = 3
    PATCH = 2
    BUILD = 0

    def self.version
      [MAJOR, MINOR, PATCH, BUILD].compact.join('.').freeze
    end

  end
end
