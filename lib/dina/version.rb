module Dina
  class Version

    MAJOR = 1
    MINOR = 0
    PATCH = 1
    BUILD = 0

    def self.version
      [MAJOR, MINOR, PATCH, BUILD].compact.join('.').freeze
    end

  end
end
