class AddConsumerToPreviousConsumptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :previous_consumptions, :consumer, foreign_key: true
  end
end
