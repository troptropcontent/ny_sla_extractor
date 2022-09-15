module Nysla
  class DataExtractor
    def initialize(link_element)
      @link_element = link_element
      @license_id = data_from_text['license']
      @name = data_from_text['name']
      @localisation = data_from_text['localisation']
      @link = link_element.to_h['href']
      @number_of_pages = data_from_href['numpages'].first.to_i
    end

    private

    def data_from_text
      @data_from_text ||= @link_element.text.match(/(?<name>.+) - (?<license>\d{7})\((?<localisation>.+)\)$/).named_captures
    end

    def data_from_href
      CGI.parse(URI.parse(@link).query)
    end
  end
end
