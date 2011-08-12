ActionMailer::Base.smtp_settings = {  
  :address              => "mail.suite101.com",  
  :port                 => 587,  
  :domain               => "suite101.com",  
  :user_name            => "jennifer",  
  :password             => "jen51*ch",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}