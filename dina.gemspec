$:.push File.expand_path("../lib", __FILE__)

require "dina/version"

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 3.3'
  s.name        = 'dina'
  s.version     = Dina::Version.version
  s.license     = 'MIT'
  s.date        = '2024-05-27'
  s.summary     = "DINA ruby gem"
  s.description = "Authenicate against DINA's Keycloak and access its models"
  s.authors     = ["David P. Shorthouse", "Julia Douglas Freitas"]
  s.email       = 'david.shorthouse@agr.gc.ca'
  s.homepage    = 'https://github.com/dshorthouse/dina'

  s.files        = Dir['MIT-LICENSE', 'README.rdoc', 'lib/**/*']
  s.require_path = 'lib'
  s.rdoc_options.concat ['--encoding',  'UTF-8']
  s.add_runtime_dependency "json_api_client", "~> 1.20"
  s.add_runtime_dependency "keycloak", "~> 3.2.1"
  s.add_runtime_dependency "securerandom", "~> 0.3.0"
  s.add_runtime_dependency "require_all", "~> 3.0.0"
  s.add_runtime_dependency "faraday-multipart", "~> 1.0.4"
  s.add_development_dependency "rake", "~> 13"
  s.add_development_dependency "rspec", "~> 3.10"
  s.add_development_dependency "rspec-uuid", "~> 0.5.0"
  s.add_development_dependency "bundler", "~> 2"
end
