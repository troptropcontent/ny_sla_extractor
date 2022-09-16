module Nysla
  class DataExtractor
    def initialize(link_element)
      @link_element = link_element
    end

    def license_id
      data_from_text['license']
    end

    def name
      data_from_text['name']
    end

    def localisation
      data_from_text['localisation']
    end

    def href
      @href ||= @link_element.to_h['href']
    end

    def number_of_pages
      data_from_href['numpages'].first.to_i
    end

    def to_h
      {
        license_id: license_id,
        name: name,
        localisation: localisation,
        href: href,
        number_of_pages: number_of_pages
      }
    end

    private

    def data_from_text
      @data_from_text ||= @link_element.text.match(/(?<name>.+) - (?<license>\d{7})\((?<localisation>.+)\)$/).named_captures
    end

    def data_from_href
      @data_from_href ||= CGI.parse(URI.parse(href).query)
    end
  end
end
