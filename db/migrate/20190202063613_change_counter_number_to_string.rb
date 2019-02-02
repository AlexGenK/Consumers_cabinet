class ChangeCounterNumberToString < ActiveRecord::Migration[5.2]
  def change
    change_column :counters, :number, :string
  end
end
