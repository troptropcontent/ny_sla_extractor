module Nysla
  class LinkExtractor
    def initialize(html_file)
      @html_file = html_file
    end

    def call
      @html_file.xpath("//a[starts-with(@href, 'https://www.nyslapricepostings.com/showpage.asp')]")
    end
  end
end
