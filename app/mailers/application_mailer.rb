class ApplicationMailer < ActionMailer::Base
  default from: ENV['CONSUMERS_CABINET_EMAIL']
  layout 'mailer'
end
