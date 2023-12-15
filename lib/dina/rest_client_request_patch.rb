# Keycloak Client depends on RestClient & so verifying SSL must be accommodated here
# Not a great solution, ideally should be initialized prior to calling Keycloak::Client.get_token

module RestClient
  class Request
    orig_initialize = instance_method(:initialize)
  
    define_method(:initialize) do |args|
      args[:verify_ssl] = false
      orig_initialize.bind(self).(args)
    end
  end
end