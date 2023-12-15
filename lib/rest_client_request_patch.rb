# Keycloak Client depends on RestClient & so verifying SSL must be accommodate here

module RestClient
  class Request
    orig_initialize = instance_method(:initialize)
  
    define_method(:initialize) do |args|
      if Dina.config.verify_ssl == false
        args[:verify_ssl] = false
        orig_initialize.bind(self).(args)
      end
    end
  end
end