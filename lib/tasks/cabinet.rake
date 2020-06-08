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

  desc "Get newest certificates"
  task get_certs: :environment do
    require 'net/ftp'

    Service.create(last_cert_time: "") unless Service.first

    Net::FTP.open(ENV['CONSUMERS_CABINET_FTP_HOST'], 
              ENV['CONSUMERS_CABINET_FTP_USERNAME'],
              ENV['CONSUMERS_CABINET_FTP_PASSWORD'],) do |ftp|
      @max_file_time = ""
      ftp.nlst.each do |filename|
        file_time = ftp.mdtm(filename)
        @max_file_time = file_time if file_time > @max_file_time 
      end
    end
    if Service.first.last_cert_time < @max_file_time 
      Service.first.update(last_cert_time: @max_file_time)
      Admin::FillingCertificatesController.new.start 
    end
  end

  desc "Delete all certificates"
  task del_certs: :environment do
    Certificate.delete_all
    Service.first.update(last_cert_time: "")
  end

end
