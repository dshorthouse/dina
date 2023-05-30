require "keycloak"
require "json_api_client"
require "time"
require "date"
require "securerandom"
require "require_all"
require_all File.join(File.dirname(__FILE__), 'dina')

module Dina

  JsonApiClient::Paginating::NestedParamPaginator.page_param = "offset"
  JsonApiClient::Paginating::NestedParamPaginator.per_page_param = "limit"
  JsonApiClient::Schema.register array: ArrayCaster
  JsonApiClient::Schema.register hash: HashCaster
  JsonApiClient::Schema.register date: DateCaster
  JsonApiClient::Schema.register multilingual_title: MultilingualTitleCaster
  JsonApiClient::Schema.register multilingual_description: MultilingualDescriptionCaster

  module_function

  def classes
    BaseModel.subclasses
  end

  def config
    Authentication.instance.config
  end

  def config=(options = {})
    Authentication.instance.config = options
  end

  def header
    Authentication.instance.header
  end

  def flush
    Authentication.instance.flush
  end

  def flush_config
    Authentication.instance.flush_config
  end

end
