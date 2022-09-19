require_relative './models/company'
module Nysla::Converters
  class ComplexLinkToCompany
    def initialize(link_element, ul_element)
      @link_element = link_element
      @ul_element = ul_element
    end

    def call
      Models::Company.new(license_id, name, localisation, pages)
    end

    private

    def license_id
      data_from_text['license']
    end

    def name
      data_from_text['name']
    end

    def localisation
      data_from_text['localisation']
    end

    def pages
      links_from_ul.each_with_object({}) do |link, memo|
        memo[link.text] = numpages_from_link_element(link)
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
