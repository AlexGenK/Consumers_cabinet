class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.belongs_to :consumer, index: true
      t.string :number
      t.date :date

      t.timestamps
    end
  end
end
