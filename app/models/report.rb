class Report < ApplicationRecord
  enum month: %i[january february march april may june july august september october november december]
  enum kind: %w[WW LW WR LR]
  has_many :companies
  accepts_nested_attributes_for :companies
end
