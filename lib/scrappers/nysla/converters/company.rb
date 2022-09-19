require_relative 'reports_to_urls'
module Nysla::Converters
  class Company
    attr_reader :license, :name, :localisation, :pages

    def initialize(license, name, localisation, pages)
      @license = license
      @name = name
      @localisation = localisation
      @pages = pages
    end

    def number_of_pages
      @reports.values.sum
    end

    def report_page_urls
      Nysla::Converters::PagesToUrls.new(self).call
    end
  end
end
