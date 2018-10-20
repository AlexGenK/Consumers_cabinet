class Consumer < ApplicationRecord
  validates :name, :onec_id, presence: true
  validates :name, :onec_id, uniqueness: true

  has_many :cоunters
end
