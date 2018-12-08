class AddLevelAndPointNameToPreviousConsumptions < ActiveRecord::Migration[5.2]
  def change
    add_column :previous_consumptions, :level, :integer, default: 0
    add_column :previous_consumptions, :point_name, :string
  end
end
