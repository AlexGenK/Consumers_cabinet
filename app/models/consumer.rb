class Consumer < ApplicationRecord
  has_many :contracts, dependent: :destroy
  has_many :previous_consumptions, dependent: :destroy
  has_one :current_consumption, dependent: :destroy

  validates :name, :onec_id, presence: true
  validates :name, :onec_id, uniqueness: true

  def send_power_to_current
    all_power = 0
    self.contracts.all.each do |contract|
      contract.counters.all.each do |counter|
        all_power += counter.all_current_power
      end
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
