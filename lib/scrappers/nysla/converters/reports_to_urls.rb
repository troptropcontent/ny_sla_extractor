module Nysla::Converters
  class ReportsToUrls
    BASE_SHOW_URL = 'https://www.nyslapricepostings.com/showpage.asp?previous=&posttype=WR&scale=.75'
    def initialize(company)
      @company = company
    end

    def call
      @company.reports.map do |report_id, numpages|
        generate_report_page_urls(report_id, numpages)
      end.flatten
    end

    def number_of_pages
      @reports.values.sum
    end

    def report_page_urls
      @company.reports
    end

    private

    def base_url_with_page_params(report_id, pageno, numpages)
      [
        BASE_SHOW_URL,
        "co=#{[@company.license, report_id].join('-')}",
        "pageno=#{pageno}",
        "numpages=#{numpages}"
      ].join('&')
    end

    def generate_report_page_urls(report_id, numpages)
      (1..numpages).map do |n|
        base_url_with_page_params(report_id, n, numpages)
      end
    end
  end
end
