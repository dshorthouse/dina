module Dina
  class DinaException < StandardError; end
  class TokenStoreFileNotFound < DinaException; end
  class TokenStoreContentInvalid < DinaException; end
  class ConfigItemMissing < DinaException; end
  class ObjectInvalid < DinaException; end
  class PropertyInvalid < ObjectInvalid; end
  class PropertyValueInvalid < ObjectInvalid; end
end
