class AddCountOutToCounters < ActiveRecord::Migration[5.2]
  def change
    add_column :counters, :count_out, :boolean, default: false
  end
end
