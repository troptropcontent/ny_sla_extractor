module Nysla::Converters::Models
  class Report
    def initialize(month, year, kind, companies)
      @month = month
      @year = year
      @kind = kind
      @companies = companies
    end

    def to_params
      {
        month: @month,
        year: @year,
        kind: @kind,
        companies_attributes: @companies.to_params
      }
    end
  end
end
