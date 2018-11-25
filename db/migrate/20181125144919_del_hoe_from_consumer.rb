class DelHoeFromConsumer < ActiveRecord::Migration[5.2]
  def change
    remove_column :consumers, :dog_hoe_num
    remove_column :consumers, :dog_hoe_date
  end
end
