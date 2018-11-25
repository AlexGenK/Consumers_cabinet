class AddAccountToCounter < ActiveRecord::Migration[5.2]
  def change
    add_column :counters, :account, :string
  end
end
