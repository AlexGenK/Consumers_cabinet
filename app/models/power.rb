class Power < ApplicationRecord
  validates :active, numericality: { greater_than_or_equal_to: 0, message: "Активная энергия не может быть меньше 0" }
  validates :before_active, numericality: { greater_than_or_equal_to: 0, message: "Активная энергия не может быть меньше 0" }
  validates :reactive, numericality: { greater_than_or_equal_to: 0, message: "Реактивная энергия не может быть меньше 0" }
  validates :before_reactive, numericality: { greater_than_or_equal_to: 0, message: "Реактивная энергия не может быть меньше 0" }
  validates :generation, numericality: { greater_than_or_equal_to: 0, message: "Генерация не может быть меньше 0" }
  validates :before_generation, numericality: { greater_than_or_equal_to: 0, message: "Генерация не может быть меньше 0" }
  validates_with BeforeAfterValidator

  belongs_to :counter

  def active_result
    active - before_active
  end

  def reactive_result
    reactive - before_reactive
  end

  def generation_result
    generation - before_generation
  end

end
