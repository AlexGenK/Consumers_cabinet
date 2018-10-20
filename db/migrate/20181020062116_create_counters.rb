class CreateCounters < ActiveRecord::Migration[5.2]
  def change
    create_table :counters do |t|
      t.belongs_to :consumer, index: true
      t.integer :number
      t.integer :ratio

      t.timestamps
    end
  end
end
