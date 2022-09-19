require_relative './extractors/simple_companies'
require_relative './extractors/complex_companies'
require_relative './converters/models/companies'
module Nysla
  class CompaniesExtractor
    def initialize(html_file)
      @html_file = html_file
    end

    def call
      Converters::Models::Companies.new(
        [
          *Extractors::SimpleCompanies.new(@html_file).call,
          *Extractors::ComplexCompanies.new(@html_file).call
        ]
      )
    end
  end
end
