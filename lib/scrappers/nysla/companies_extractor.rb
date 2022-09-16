require_relative './extractors/simple_companies'
require_relative './extractors/complex_companies'
module Nysla
  class CompaniesExtractor
    def initialize(html_file)
      @html_file = html_file
    end

    def call
      [
        *Extractors::SimpleCompanies.new(@html_file).call,
        *Extractors::ComplexCompanies.new(@html_file).call
      ]
    end
  end
end
