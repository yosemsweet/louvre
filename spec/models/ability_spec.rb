require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  
  before(:each) do
    @user = Factory.create(:user)
  end
  
  context "for a page" do
    before(:each) do
      @canvas = Factory.create(:canvas)
    end
    
    it "should not allow users to update" do
	    @ability = Ability.new(@user)
      @ability.should_not be_able_to(:update, Factory.build(:page, :canvas => @canvas))
    end
    
    it "should allow members to update" do
      @user.set_canvas_role(@canvas, :member)
	    @ability = Ability.new(@user)
      @ability.should be_able_to(:update, Factory.build(:page, :canvas => @canvas))
    end
  
  end

  context "for users" do    
    it "should not allow non-admins to :make_admin" do
			@user.admin = false
	    @ability = Ability.new(@user)
      @ability.should_not be_able_to(:make_admin, User)
    end
    
    it "should allow admins to :make_admin" do
      @user.admin = true
	    @ability = Ability.new(@user)
      @ability.should be_able_to(:make_admin, User)
    end
  
  end
  
end