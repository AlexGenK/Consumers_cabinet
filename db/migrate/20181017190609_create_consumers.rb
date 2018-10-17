class CreateConsumers < ActiveRecord::Migration[5.2]
  def change
    create_table :consumers do |t|
      t.string  :name
      t.string  :edrpou
      t.string  :dog_eh_num
      t.date    :dog_eh_date
      t.string  :dog_hoe_num
      t.date    :dog_hoe_date
      t.integer :onec_id
      t.date    :report_date
      t.string  :user_email
      t.string  :manager_email

      t.timestamps
    end
  end
end
