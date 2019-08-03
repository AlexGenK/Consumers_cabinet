class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :company
      t.integer :edrpou
      t.integer :account
      t.string :bank
      t.integer :mfo

      t.timestamps
    end
  end
end
