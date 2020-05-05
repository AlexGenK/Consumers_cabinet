class CreateCertificates < ActiveRecord::Migration[5.2]
  def change
    create_table :certificates do |t|
      t.belongs_to :consumer, index: true
      t.date :date

      t.timestamps
    end
  end
end
