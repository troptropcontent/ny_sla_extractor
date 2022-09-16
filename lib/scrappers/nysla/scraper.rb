require 'open-uri'
require 'nokogiri'
require_relative 'companies_extractor'
require_relative 'date_extractor'

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

    def number_of_pages
      @number_of_pages ||= @companies.sum(&:number_of_pages)
    end

    def to_h
      {
        links: companies,
        month: month,
        year: year,
        number_of_pages: number_of_pages
      }
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
