module Nysla::Converters
  class Company
    attr_reader :license, :name, :localisation, :extensions

    def initialize(license, name, localisation, reports)
      @license = license
      @name = name
      @localisation = localisation
      @reports = reports
    end

    def number_of_pages
      @reports.values.sum
    end
  end
end
