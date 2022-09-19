require_relative './models/page'
require_relative './models/pages'
module Nysla::Converters
  class ExtensionAndNumpagesToPages
    BASE_SHOW_URL = 'https://www.nyslapricepostings.com/showpage.asp?previous=&posttype=WR&scale=.75'
    def initialize(extension, numpages)
      @extension = extension
      @numpages = numpages
    end

    def call
      Models::Pages.new(
        (1..@numpages).map do |n|
          Models::Page.new(
            @extension,
            n,
            @numpages
          )
        end
      )
    end
  end
end
