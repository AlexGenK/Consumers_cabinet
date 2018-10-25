class AddBeforePowerToPowers < ActiveRecord::Migration[5.2]
  def change
    add_column :powers, :before_active, :integer
    add_column :powers, :before_reactive, :integer
    add_column :powers, :before_generation, :integer
  end
end
