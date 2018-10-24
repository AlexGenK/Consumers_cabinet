class Consumer < ApplicationRecord
  has_many :counters

  validates :name, :onec_id, presence: true
  validates :name, :onec_id, uniqueness: true
end
