class AddConsumersFullname < ActiveRecord::Migration[5.2]
  def change
    add_column :consumers, :fullname, :string
  end
end
