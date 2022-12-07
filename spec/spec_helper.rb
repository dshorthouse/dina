$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'rspec/uuid'
require 'json'
require 'require_all'
require 'dina'

def mock_token_path
  File.expand_path("../resources/token.json", __FILE__)
end

def mock_token
  JSON.parse(::File.read(mock_token_path), symbolize_names: true)
end
