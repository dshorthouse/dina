module Dina
  class File
    attr_accessor :file_path, :group, :is_derivative

    def self.find(group:, id:)
      obj = self.new
      obj.group = group
      RestClient::Request.execute(
        method: :get,
        headers: { authorization: Dina::Authentication.header },
        url: obj.url + "/#{id}"
      )
    end

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
      validate_params
      response = RestClient::Request.execute(
        method: :post,
        headers: { authorization: Dina::Authentication.header },
        url: (!is_derivative) ? url : url + "/derivative",
        payload: {
          multipart: true,
          file: file
        }
      )
      JSON.parse(response, symbolize_names: true)
    end

    private

    def validate_params
      if group.nil?
        raise ObjectInvalid, "#{self.class} is invalid. group is required."
      end
      if file_path.nil? || !::File.exist?(file_path)
        raise ObjectInvalid, "#{self.class} is invalid. file not found in file_path."
      end
    end

  end
end
