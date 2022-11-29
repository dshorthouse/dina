module Dina
  class File
    attr_accessor :file_path, :group

    def initialize
    end

    def endpoint_path
      "objectstore-api/"
    end

    def table_name
      "file/#{@group}"
    end

    def url
      Dina::Authentication.endpoint_url + endpoint_path + table_name
    end

    def file
      ::File.new(file_path)
    end

    def save
      if group.nil?
        raise ObjectInvalid, "#{self.class} is invalid. group is required."
      end
      if file_path.nil? || !::File.exist?(file_path)
        raise ObjectInvalid, "#{self.class} is invalid. file not found in file_path."
      end
      response = RestClient::Request.execute(
        method: :post,
        headers: { authorization: Dina::Authentication.header },
        url: url,
        payload: {
          multipart: true,
          file: file
        }
      )
      JSON.parse(response, symbolize_names: true)
    end

  end
end
