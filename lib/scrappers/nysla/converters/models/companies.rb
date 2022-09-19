require_relative 'company'

module Nysla::Converters::Models
  class Companies
    def initialize(list)
      @list = list
    end

    def to_params
      @list.map(&:to_params)
    end
  end
end
