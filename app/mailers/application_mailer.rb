class ApplicationMailer < ActionMailer::Base
  default from: 'support@infiniteq.net', bcc: 'infiniteq@irrationaldesign.com'
  layout 'mailer'
end
