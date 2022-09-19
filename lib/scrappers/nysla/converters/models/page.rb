module Nysla::Converters::Models
  class Page
    def initialize(extension, nopage, numpages)
      @extension = extension
      @nopage = nopage
      @numpages = numpages
    end

    def to_params
      {
        extension: @extension,
        nopage: @nopage,
        numpages: @numpages
      }
    end
  end
end
