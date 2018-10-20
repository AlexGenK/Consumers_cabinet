class Counter < ApplicationRecord
  has_many :powers
  validates :number, presence: true
  validates :ratio, numericality: { greater_than: 0 }
end
