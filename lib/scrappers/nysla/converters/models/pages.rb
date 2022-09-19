module Nysla::Converters::Models
  class Pages
    attr_reader :list

    def initialize(list = [])
      @list = list
    end

    def to_params
      @list.map(&:to_params)
    end

    def merge(other_pages)
      @list += other_pages.list
    end
  end
end
