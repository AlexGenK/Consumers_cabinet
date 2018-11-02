class Consumer < ApplicationRecord
  has_many :counters
  has_many :previous_consumptions

  validates :name, :onec_id, presence: true
  validates :name, :onec_id, uniqueness: true
end
