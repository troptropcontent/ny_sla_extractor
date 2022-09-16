require_relative 'regex_handler'
require_relative '../converters/simple_link_to_company'
module Nysla
  module Extractors
    class SimpleCompanies
      BASE_SHOW_URL = 'https://www.nyslapricepostings.com/showpage.asp'
      def initialize(html_file)
        @html_file = html_file
      end

      def call
        simple_link_elements.map do |link_element|
          Converters::SimpleLinkToCompany.new(link_element).call
        end
      end

      private

      def simple_link_elements
        @simple_link_elements ||= @html_file.xpath(
          "//a[regex(text(),'^.+ - \\d{7}\\(.+\\)$') and starts-with(@href, '#{BASE_SHOW_URL}')]", RegexHandler.new
        )
      end
    end
  end
end
