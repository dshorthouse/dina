require "keycloak"
require "json_api_client"
require "time"
require "securerandom"
require "require_all"
require_all File.join(File.dirname(__FILE__), 'dina')

module Dina

  JsonApiClient::Paginating::NestedParamPaginator.page_param = "offset"
  JsonApiClient::Paginating::NestedParamPaginator.per_page_param = "limit"
  JsonApiClient::Schema.register array: Dina::ArrayCaster
  JsonApiClient::Schema.register object: Dina::ObjectCaster
  JsonApiClient::Schema.register multilingual_title: Dina::MultilingualTitleCaster
  JsonApiClient::Schema.register multilingual_description: Dina::MultilingualDescriptionCaster

  module_function

  def classes
    BaseModel.subclasses
  end

  def config(options = {})
    Authentication.instance.config(options)
  end

  def header
    Authentication.instance.header
  end

  def flush
    Authentication.instance.flush
  end

end
