require_rel 'base_model'

module Dina
  class File < BaseModel
    property :id, type: :string, default: SecureRandom.uuid

    def self.endpoint_path
      "objectstore-api/"
    end

    def self.table_name
      "file"
    end

    #TODO: a "bucket" as part of the path (=table_name) to permit POST with necessary permissions
    #TODO: body not JSON but an asset

=begin

    def initialize(bucket:, file:)
      if !file.is_a?(::File) || !::File.exist?(file)
        raise Exception.new "file is not of class File or does not exist"
      end
      super
      set_headers
    end

    private

    def set_headers
      headers = {
        content_type: "application/octet-stream",
        content_disposition: "form-data; name=file; filename=#{::File.basename(file.path)}"
      }
      self.custom_headers.merge(headers)
    end
=end

  end
end
