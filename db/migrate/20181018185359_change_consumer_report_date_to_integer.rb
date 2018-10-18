class ChangeConsumerReportDateToInteger < ActiveRecord::Migration[5.2]
  def change
    remove_column :consumers, :report_date
    add_column :consumers, :report_date, :integer
  end
end
