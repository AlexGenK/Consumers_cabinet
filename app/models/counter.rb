class Counter < ApplicationRecord
  has_many :powers, dependent: :destroy
  belongs_to :consumer

  validates :number, presence: true
  validates :ratio, numericality: { greater_than: 0 }
end
