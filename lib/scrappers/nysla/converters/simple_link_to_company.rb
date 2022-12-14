require_relative './models/company'
require_relative 'extension_and_numpages_to_pages'

module Nysla::Converters
  class SimpleLinkToCompany
    def initialize(link_element)
      @link_element = link_element
    end

    def call
      Models::Company.new(license, name, localisation, pages)
    end

    private

    def license
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

    def pages
      ExtensionAndNumpagesToPages.new('', number_of_pages).call
    end

    def number_of_pages
      data_from_href['numpages'].first.to_i
    end

    def data_from_text
      @data_from_text ||= @link_element.text.match(/(?<name>.+) - (?<license>\d{7})\((?<localisation>.+)\)$/).named_captures
    end

    def data_from_href
      @data_from_href ||= CGI.parse(URI.parse(href).query)
    end
  end
end
