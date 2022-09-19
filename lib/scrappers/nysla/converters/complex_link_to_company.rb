require_relative './models/company'
require_relative './models/pages'
require_relative 'extension_and_numpages_to_pages'
module Nysla::Converters
  class ComplexLinkToCompany
    def initialize(link_element, ul_element)
      @link_element = link_element
      @ul_element = ul_element
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

    def pages
      links_from_ul.each_with_object(Models::Pages.new) do |link, memo|
        memo.merge(ExtensionAndNumpagesToPages.new(link.text, numpages_from_link_element(link)).call)
      end
    end

    def href(link_from_ul)
      link_from_ul.to_h['href']
    end

    def number_of_pages
      links_from_ul.sum { |link| numpages_from_link_element(link) }
    end

    def data_from_text
      @data_from_text ||= @link_element.text.match(/(?<name>.+) - (?<license>\d{7})\((?<localisation>.+)\)$/).named_captures
    end

    def links_from_ul
      @links_from_ul ||= @ul_element.children.css('a')
    end

    def query_params(href)
      CGI.parse(URI.parse(href).query)
    end

    def numpages_from_link_element(link_element)
      query_params(href(link_element))['numpages'].first.to_i
    end
  end
end
