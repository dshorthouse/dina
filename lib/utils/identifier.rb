# encoding: utf-8
class String
  def is_orcid?
    ::Dina::Identifier.is_orcid_regex.match?(self) &&
    ::Dina::Identifier.orcid_valid_checksum(self)
  end

  def is_wiki_id?
    ::Dina::Identifier.is_wiki_regex.match?(self)
  end

  def is_doi?
    ::Dina::Identifier.is_doi_regex.match?(self)
  end

  def orcid_from_url
    ::Dina::Identifier.extract_orcid_regex.match(self)[0] rescue nil
  end

  def wiki_from_url
    ::Dina::Identifier.extract_wiki_regex.match(self)[0] rescue nil
  end

end

module Dina
  class Identifier

    class << self
      def is_orcid_regex
        /^0000-000(1-[5-9]|2-[0-9]|3-[0-4])\d{3}-\d{3}[\dX]$/
      end

      def is_wiki_regex
        /^Q[0-9]{1,}$/
      end

      def is_doi_regex
        /^10.\d{4,9}\/[-._;()\/:<>A-Z0-9]+$/i
      end

      def orcid_valid_checksum(orcid_string)
        parts = orcid_string.scan(/[0-9X]/)
        mod = parts[0..14].map(&:to_i)
                          .inject { |sum, n| (sum + n)*2 }
                          .modulo(11)
        result = (12 - mod) % 11
        parts.last == ((result == 10) ? "X" : result.to_s)
      end

      def extract_orcid_regex
        /(?<=orcid\.org\/)(\d{4}-){3}\d{3}[0-9X]{1}/
      end

      def extract_wiki_regex
        /(?:wikidata\.org\/(entity|wiki)\/)\K(Q[0-9]{1,})/
      end

    end

  end
end
