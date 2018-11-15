class ApplicationMailer < ActionMailer::Base
  default from: ENV['CONSUMERS_EMAIL']
  layout 'mailer'
end
