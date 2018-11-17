class Counter < ApplicationRecord
  has_many :powers, dependent: :destroy
  belongs_to :consumer

  validates :number, presence: true
  validates :ratio, numericality: { greater_than: 0 }

  def all_current_power
    power = powers.where("measure_date >= ? AND measure_date <= ?",
                              DateTime.now.beginning_of_month.to_date,
                              DateTime.now.end_of_month.to_date).last
    ((power.active_result * ratio) +
    (power.reactive_result * ratio) +
    (power.generation_result * ratio)).round
  end
end
