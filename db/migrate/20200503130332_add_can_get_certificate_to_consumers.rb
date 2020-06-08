class AddCanGetCertificateToConsumers < ActiveRecord::Migration[5.2]
  def change
    add_column :consumers, :can_get_certificate, :boolean, default: false
  end
end
