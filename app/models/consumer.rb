class Consumer < ApplicationRecord
  has_many :counters, dependent: :destroy
  has_many :previous_consumptions, dependent: :destroy
  has_one :current_consumption, dependent: :destroy

  validates :name, :onec_id, presence: true
  validates :name, :onec_id, uniqueness: true
end
