require_relative 'regex_handler'
require_relative '../converters/complex_link_to_company'
module Nysla
  module Extractors
    class ComplexCompanies
      def initialize(html_file)
        @html_file = html_file
      end

      def call
        base_link_elements.map do |link_element|
          Converters::ComplexLinkToCompany.new(link_element, coresponding_ul_element(link_element)).call
        end
      end

      private

      def base_link_elements
        @base_link_elements ||= @html_file.xpath(
          "//a[regex(text(),'^.+ - \\d{7}\\(.+\\)$') and @href='']", Nysla::Extractors::RegexHandler.new
        )
      end

      def coresponding_ul_element(link_element)
        name = name_from_link_text(link_element.text)
        @html_file.xpath("//ul[@title=\"#{name}\"]").first
      end

      def name_from_link_text(link_text)
        link_text.match(/(?<name>^.+) - /).named_captures['name']
      end
    end
  end
end
