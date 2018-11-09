class RenameConsumerEmailsFieldToNames < ActiveRecord::Migration[5.2]
  def change
    rename_column :consumers, :user_email, :client_username
    rename_column :consumers, :manager_email, :manager_username
  end
end
