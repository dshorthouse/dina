require_rel '../base_model'
require_rel 'file_connection'

module Dina

  class File < BaseModel
    property :id, type: :string, default: SecureRandom.uuid_v7
    property :group, type: :string
    property :filePath, type: :string
    property :fileName, type: :string
    property :dcFormat, type: :string
    property :is_derivative, type: :boolean

    self.connection_class = FileConnection

    validates_presence_of :group, message: "group is required"
    validates_presence_of :filePath, message: "filePath is required"
    validates_presence_of :fileName, message: "fileName is required"
    validates_presence_of :dcFormat, message: "dcFormat is required"

    def self.endpoint_path
      "objectstore-api/"
    end

    def self.table_name
      "file"
    end

    def self.custom_headers
      { content_type: "multipart/form-data", authorization: Dina.header }
    end

    private

    def on_before_save
      if !self.filePath.nil? && !::File.exist?(self.filePath)
        raise PropertyValueInvalid, "#{self.class} is invalid. File not found in filePath."
      end
      super
    end

  end
end