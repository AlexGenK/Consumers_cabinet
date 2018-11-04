class AddFullNameToConsumers < ActiveRecord::Migration[5.2]
  def change
    add_column :consumers, :full_name, :string
  end
end
