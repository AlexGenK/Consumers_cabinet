class CreateCurrentConsumptions < ActiveRecord::Migration[5.2]
  def change
    create_table :current_consumptions do |t|
      t.belongs_to :consumer, index: true
      t.integer :power
      t.float :tariff
      t.float :money

      t.timestamps
    end
  end
end
