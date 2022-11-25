module Dina
  class Version

    MAJOR = 0
    MINOR = 1
    PATCH = 0
    BUILD = 0

    def self.version
      [MAJOR, MINOR, PATCH, BUILD].compact.join('.').freeze
    end

  end
end
