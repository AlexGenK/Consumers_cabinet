class Power < ApplicationRecord
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
