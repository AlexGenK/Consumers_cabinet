class CreatePreviousConsumptions < ActiveRecord::Migration[5.2]
  def change
    create_table :previous_consumptions do |t|
      t.date :date
      t.integer :power
      t.float :tariff
      t.float :money

      t.timestamps
    end
  end
end
