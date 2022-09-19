module Nysla
  module Converters
    module Models
      class Company
        attr_reader :license, :name, :localisation, :pages

        def initialize(license, name, localisation, pages)
          @license = license
          @name = name
          @localisation = localisation
          @pages = pages
        end

        def number_of_pages
          @reports.values.sum
        end

        def to_params
          {
            license: @license,
            name: @name,
            localisation: @localisation,
            pages_attributes: pages.to_params
          }
        end

        def report_page_urls
          Nysla::Converters::PagesToUrls.new(self).call
        end
      end
    end
  end
end
