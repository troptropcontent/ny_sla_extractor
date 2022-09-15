module Nysla
  class DateExtractor
    def initialize(html_file)
      @html_file = html_file
    end

    def call
      month_text = @html_file.xpath("//b[contains(text(), 'Pricing for')]/text()").first.text
      month_text.match(/^Pricing for (?<month>[a-zA-Z]+), (?<year>[0-9]+)/).named_captures
    end
  end
end
