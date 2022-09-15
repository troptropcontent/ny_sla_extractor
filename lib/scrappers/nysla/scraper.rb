require 'open-uri'
require 'nokogiri'
require_relative 'link_extractor'
require_relative 'date_extractor'

module Nysla
  class Scraper
    attr_reader :links, :month, :year

    BASE_URL = 'https://www.nyslapricepostings.com/PricePostings.asp?postingType=WR'
    def initialize
      @links = fetched_links
      @month = fetched_date['month'].downcase
      @year = fetched_date['year']
    end

    private

    def html_file
      @html_file ||= Nokogiri::HTML(URI.open(BASE_URL).read)
    end

    def fetched_links
      LinkExtractor.new(html_file).call
    end

    def fetched_date
      @fetched_date ||= DateExtractor.new(html_file).call
    end
  end
end
