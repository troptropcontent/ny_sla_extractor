require 'open-uri'
require 'nokogiri'

class NYSLA
  BASE_URL = 'https://www.nyslapricepostings.com/PricePostings.asp?postingType=WR'
  def initialize
    links = []
  end

  def fetch_links
    html_file.xpath("//a[starts-with(@href, 'https://www.nyslapricepostings.com/showpage.asp')]/@href").map(&:value)
  end

  private

  def html_file
    @html_file ||= Nokogiri::HTML(URI.open(BASE_URL).read)
  end
end
