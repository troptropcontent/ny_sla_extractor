module Nysla
  class DataExtractor
    def initialize(link_element)
      @link_element = link_element
      @license_id = data_from_text['license']
      @name = data_from_text['name']
      @localisation = data_from_text['localisation']
      @link = link_element.to_h['href']
    end

    private

    def data_from_text
      @data_from_text ||= @link_element.text.match(/(?<name>.+) - (?<license>\d{7})\((?<localisation>.+)\)$/).named_captures
    end
  end
end
