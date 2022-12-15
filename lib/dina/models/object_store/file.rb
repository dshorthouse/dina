module Dina
  class File < BaseModel
    attr_accessor :file_path, :group, :is_derivative, :id

    def self.verify_ssl
      begin
        connection_options[:ssl][:verify]
      rescue
        true
      end
    end

    def self.find(group:, id:)
      obj = self.new
      obj.group = group
      RestClient::Request.execute(
        method: :get,
        headers: { authorization: Dina::Authentication.header },
        url: obj.url + "/#{id}",
        verify_ssl: verify_ssl
      )
    end

    def initialize
    end

    def endpoint
      Dina::Authentication.endpoint_url
    end

    def endpoint_path
      "objectstore-api/"
    end

    def table_name
      "file/#{@group.downcase}"
    end

    def url
      endpoint + "/" + endpoint_path + table_name
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
        },
        verify_ssl: self.class.verify_ssl
      )
      json = JSON.parse(response, symbolize_names: true)
      self.id = json[:uuid]
      json
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
