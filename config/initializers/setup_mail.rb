
# ActionMailer::Base.smtp_settings = {  
#   :address              => "mail.suite101.com",  
#   :port                 => 25,  
#   :domain               => "suite101.com",  
#   :user_name            => "noreply@suite101.com",  
#   :password             => "kDa891WW",  
#   :authentication       => "plain",  
#   :enable_starttls_auto => true  
# }

ActionMailer::Base.smtp_settings = {
  :user_name => "administrator@loorp.com",
  :password => "rabbit942",
  :domain => "loorp.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}