require 'spec_helper'

describe InvitesController do
  describe 'post create' do
    
    describe 'create a new invite' do
      describe 'with valid parameter' do
        let(:invite) { mock_model(Invite).as_null_object }
        before(:each) do
          Invite.stub(:save).and_return(true)
        end
        
        it "saves an invite" do
          Invite.stub(:new).and_return(invite)
          invite.should_receive(:save)  
          post :create, :invite => { :inviter => "current_user", :invitee => "test@test.com", :canvas => "current_canvas"}
        end
        
        it "should send a mail" do
        end
      end
    end
  
  end
end
