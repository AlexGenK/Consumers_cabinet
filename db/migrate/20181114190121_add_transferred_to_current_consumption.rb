class AddTransferredToCurrentConsumption < ActiveRecord::Migration[5.2]
  def change
    add_column :current_consumptions, :transferred, :boolean, default: false
  end
end
