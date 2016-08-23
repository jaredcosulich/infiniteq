ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => '25',
  :domain => 'www.infiniteq.net',
  :authentication => :plain,
  :user_name => ENV['SENDGRID_EMAIL'],
  :password => ENV['SENDGRID_PASSWORD']
}
