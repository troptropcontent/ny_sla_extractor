class Company < ApplicationRecord
  belongs_to :report
  has_many :pages
  accepts_nested_attributes_for :pages
end
