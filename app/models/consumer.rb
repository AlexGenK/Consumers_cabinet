class Consumer < ApplicationRecord
  has_many :counters, dependent: :destroy
  has_many :previous_consumptions, dependent: :destroy
  has_one :current_consumption, dependent: :destroy

  validates :name, :onec_id, presence: true
  validates :name, :onec_id, uniqueness: true

  def send_power_to_current
    all_power = 0
    self.counters.all.each do |counter|
      power = counter.powers.where("measure_date >= ? AND measure_date <= ?",
                                  DateTime.now.beginning_of_month.to_date,
                                  DateTime.now.end_of_month.to_date).last
      all_power += ((power.active_result * counter.ratio) +
                   (power.reactive_result * counter.ratio) +
                   (power.generation_result * counter.ratio)).round
    end
    all_power = all_power.round
    @cur_cons = self.current_consumption
    if @cur_cons
      all_money = all_power * @cur_cons.tariff * 1.2
      @cur_cons.update(power: all_power, money: all_money, transferred: true)
    else
      self.build_current_consumption(power: all_power, transferred: true, tariff: 0).save
    end
  end
end
