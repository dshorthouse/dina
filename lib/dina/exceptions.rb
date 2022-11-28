module Dina
  class DinaException < StandardError; end
  class TokenStoreFileNotFound < DinaException; end
  class ObjectInvalid < DinaException; end
end
