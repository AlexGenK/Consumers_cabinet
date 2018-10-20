class CreatePowers < ActiveRecord::Migration[5.2]
  def change
    create_table :powers do |t|
      t.belongs_to :counter, index: true
      t.date :measure_date
      t.integer :active
      t.integer :reactive
      t.integer :generation

      t.timestamps
    end
  end
end
