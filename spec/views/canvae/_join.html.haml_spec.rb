require 'spec_helper'

describe "canvae/join.html.haml" do
	before(:each) do
	  @canvas = Factory.create(:canvas)
		view.stubs(:current_user).returns(nil)
		view.controller.stubs(:current_user).returns(nil)
	end


	context "#join" do
	  context "not logged in" do
	     it "should exist" do
   			render :partial => 'join', :object => @canvas, :as => :canvas
   			rendered.should have_selector('#join')
   		end
  	end
    
    
	  context "logged in" do
	    before(:each) do
	      @user = Factory.create(:user)
    		view.stubs(:current_user).returns(@user)
    		view.controller.stubs(:current_user).returns(@user)
    	end
    	
	    it "should exist" do
  			render :partial => 'join', :object => @canvas, :as => :canvas
  			rendered.should have_selector('#join')
  		end  		
	  end
	 
	end
end