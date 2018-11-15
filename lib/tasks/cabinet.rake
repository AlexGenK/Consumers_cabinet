namespace :cabinet do
  desc "Clear current consumption database"
  task clear_cur_consumption: :environment do
    CurrentConsumption.delete_all
  end

  desc "Send notification email"
  task send_notif_email: :environment do
    ClientNotifierMailer.send_email.deliver_now
  end
end
