class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.text :last_cert_time

      t.timestamps
    end
  end
end
