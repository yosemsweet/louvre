class UserMailer < ActionMailer::Base
  default :from => "noreply@loorp.com"
  
  def notifications_email(user,event)
    @user = user
    @event = event
    mail(:to => @user.emails.first.address, :subject => "Loorp Updates")
  end
  
end
