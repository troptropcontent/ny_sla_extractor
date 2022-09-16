require_relative 'reports_to_urls'
module Nysla::Converters
  class Company
    attr_reader :license, :name, :localisation, :reports

    def initialize(license, name, localisation, reports)
      @license = license
      @name = name
      @localisation = localisation
      @reports = reports
    end

    def number_of_pages
      @reports.values.sum
    end

    def report_page_urls
      Nysla::Converters::ReportsToUrls.new(self).call
    end
  end
end
