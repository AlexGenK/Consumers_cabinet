class AddDefaultValuesActReactGenToPower < ActiveRecord::Migration[5.2]
  def change
    change_column :powers, :active, :decimal, precision: 10, scale: 2, default: 0
    change_column :powers, :reactive, :decimal, precision: 10, scale: 2, default: 0
    change_column :powers, :generation, :decimal, precision: 10, scale: 2, default: 0
    change_column :powers, :before_active, :decimal, precision: 10, scale: 2, default: 0
    change_column :powers, :before_reactive, :decimal, precision: 10, scale: 2, default: 0
    change_column :powers, :before_generation, :decimal, precision: 10, scale: 2, default: 0
  end
end
