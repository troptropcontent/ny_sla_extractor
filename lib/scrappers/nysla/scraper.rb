require 'open-uri'
require 'nokogiri'
require_relative 'companies_extractor'
require_relative 'date_extractor'
require_relative './converters/models/report'

module Nysla
  class Scraper
    BASE_URL = 'https://www.nyslapricepostings.com/PricePostings.asp?postingType=WR'
    def initialize; end

    def companies
      @companies ||= CompaniesExtractor.new(html_file).call
    end

    def month
      fetched_date['month'].downcase
    end

    def year
      fetched_date['year']
    end

    def to_params
      report.to_params
    end

    def report
      @report ||= Converters::Models::Report.new(
        month,
        year,
        'WR',
        companies
      )
    end

    private

    def html_file
      @html_file ||= Nokogiri::HTML(URI.parse(BASE_URL).open)
    end

    def fetched_date
      @fetched_date ||= DateExtractor.new(html_file).call
    end
  end
end
