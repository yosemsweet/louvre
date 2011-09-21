class UserMailer < ActionMailer::Base
  default :from => "noreply@loorp.com"
  
  def notifications_email(user)
    @user = current_user
    @url  = "http://loorp.com"
    mail(:to => @user.email.first, :subject => "Loorp Canvas Updates")
  end
  
end
