require_rel 'base_model'
require_rel 'file'

module Dina
  class Bucket < File
    property :id, type: :string, default: SecureRandom.uuid
  end
end
