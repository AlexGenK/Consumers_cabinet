class ClientNotifierMailer < ApplicationMailer
  def send_email
    mail(to: ENV['TEST_EMAIL'], subject: 'Напоминание о подаче отчета')
  end
end
