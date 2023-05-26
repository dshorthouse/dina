# Add alias method to File class
# exists? has been removed in latest versions of ruby
# The dependent keycloak gem still uses it
class File
  class << self
    alias_method :exists?, :exist?
  end
end
