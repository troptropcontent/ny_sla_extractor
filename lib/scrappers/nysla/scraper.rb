require 'open-uri'
require 'nokogiri'
require_relative 'link_extractor'
require_relative 'date_extractor'

module Nysla
  class Scraper
    BASE_URL = 'https://www.nyslapricepostings.com/PricePostings.asp?postingType=WR'
    def initialize; end

    def links
      @links ||= LinkExtractor.new(html_file).call
    end

    def month
      fetched_date['month'].downcase
    end

    def year
      fetched_date['year']
    end

    def number_of_pages
      @number_of_pages ||= @links.sum do |link_element|
        url = link_element.to_h['href']
        query_params = URI.parse(url).query
        CGI.parse(query_params)['numpages'].first.to_i
      end
    end

    def to_h
      {
        links: links,
        month: month,
        year: year,
        number_of_pages: number_of_pages
      }
    end

    private

    def html_file
      @html_file ||= Nokogiri::HTML(URI.open(BASE_URL).read)
    end

    def fetched_date
      @fetched_date ||= DateExtractor.new(html_file).call
    end
  end
end
