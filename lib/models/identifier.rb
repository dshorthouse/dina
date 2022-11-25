require_rel 'base_model'

module Dina
  class Identifier < BaseModel
    property :id, type: :string, default: SecureRandom.uuid
    property :namespace, type: :string
    property :value, type: :string
    property :createdBy, type: :string
    property :createdOn, type: :time

    def self.endpoint_path
      "agent-api/"
    end

    def self.table_name
      "identifier"
    end

=begin
    TODO: fix because identifier has independent model now

    def self.find_by_orcid(orcid)
      if orcid.include? "http"
        orcid = orcid.orcid_from_url
      end
      if orcid.is_orcid?
        orcid = "https://orcid.org/#{orcid}"
        where("identifiers.uri": orcid).all.first
      else
        nil
      end
    end

    def self.find_by_wikidata(wikidata)
      if wikidata.include? "http"
        wikidata = wikidata.wiki_from_url
      end
      if wikidata.is_wiki_id?
        wikidata = "http://www.wikidata.org/entity/#{wikidata}"
        where("identifiers.uri": wikidata).all.first
      else
        nil
      end
      where("identifiers.uri": wikidata).all.first
    end

    def orcid
      identifiers.select{|o| o[:type] == "ORCID"}.first[:uri]
    end

    def orcid=(uri)
      identifiers.delete_if{|o| o[:type] == "ORCID"}
      identifiers << { type: "ORCID", uri: uri }
    end

    def wikidata
      identifiers.select{|o| o[:type] == "WIKIDATA"}.first[:uri]
    end

    def wikidata=(id)
      identifiers.delete_if{|o| o[:type] == "WIKIDATA"}
      identifiers << { type: "WIKIDATA", uri: uri }
    end
=end

  end
end
