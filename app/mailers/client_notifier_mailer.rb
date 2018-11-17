class ClientNotifierMailer < ApplicationMailer
  def send_email(consumer, user)
    @consumer=consumer
    @user=user
    mail(to: @user.email, subject: 'Напоминание о подаче отчета')
  end
end
