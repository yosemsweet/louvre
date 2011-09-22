require "spec_helper"

describe UserMailer do

  describe 'notifications' do
    before (:each) do
      @user = Factory.create(:user)
      @email = Factory.create(:email, :user => @user)
      @page = Factory.create(:page)
      @event = Factory.create(:event, :user => @user, :loggable_id => @page.id, :canvas => @page.canvas)
      @mail = UserMailer.notifications_email(@event.user,@event)
    end
          
    #ensure that the subject is correct
    it 'renders the subject' do
      @mail.subject.should == 'Loorp Updates'
    end

    #ensure that the receiver is correct
    it 'renders the receiver email' do
      @mail.to.should == [@user.emails.first.address]
    end
   
    #ensure that the sender is correct
    it 'renders the sender email as noreply@loorp.com' do
      @mail.from.should == ['noreply@loorp.com']
    end

    #ensure that the @name variable appears in the email body
    it 'name appears in the email' do
      @mail.body.encoded.should match(@user.name)
    end

    #ensure that the @confirmation_url variable appears in the email body
    it 'assigns @confirmation_url' do"
      @mail.body.encoded.should match("#{@event.url}")
    end
 
  end
  
end
