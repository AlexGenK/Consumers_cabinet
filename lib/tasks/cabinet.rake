namespace :cabinet do
  desc "Clear current consumption database"
  task clear_cur_consumption: :environment do
    CurrentConsumption.delete_all
  end

  desc "Send notification email"
  task send_notif_email: :environment do
    @consumers = Consumer.where("(report_date = ?) AND (client_username <> '')", Time.now.day)
    @consumers.each do |consumer| 
      user = User.find_by(username: consumer.client_username)
      if user
        ClientNotifierMailer.send_email(consumer, user).deliver_now
        sleep 5
      end
    end
  end
end
