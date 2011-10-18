require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  
  before(:each) do
    @user = Factory.create(:user)
  end
  
  context "for a Canvas" do
    before(:each) do
      @canvas = Factory.create(:canvas)
    end
    
    it "should not allow members to apply" do
      @user.set_canvas_role(@canvas, :member)
      @ability = Ability.new(@user)
      @ability.should_not be_able_to(:apply, @canvas)
    end
    
    it "should not allow owners to apply" do
      @user.set_canvas_role(@canvas, :owner)
      @ability = Ability.new(@user)
      @ability.should_not be_able_to(:apply, @canvas)
    end
    
    it "should not allow banned to apply" do
      @user.set_canvas_role(@canvas, :banned)
      @ability = Ability.new(@user)
      @ability.should_not be_able_to(:apply, @canvas)
    end
    
    it "should allow users to apply" do
      @ability = Ability.new(@user)
      @ability.should be_able_to(:apply, @canvas)
    end

		it "should allow visitors to apply" do
			@ability = Ability.new(User.new)
			@ability.should be_able_to(:apply, @canvas)
		end
    
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

  context "for a widget" do
    before(:each) do
      @canvas = Factory.create(:canvas)
    end
    
		context "in the feed" do
			before(:each) do
				@widget = Factory.build(:widget, :canvas => @canvas)	
			end
			
	    it "should not allow users to update" do
		    @ability = Ability.new(@user)
	      @ability.should_not be_able_to(:update, @widget)
	    end
    
	    it "should allow members to update" do
	      @user.set_canvas_role(@canvas, :member)
		    @ability = Ability.new(@user)
	      @ability.should be_able_to(:update, @widget)
	    end
		end
		
		context "on a page" do
			before(:each) do
				@page = Factory.create(:page, :canvas => @canvas)
				@widget = Factory.build(:widget, :canvas => @canvas, :page => @page)	
			end
			
			it "should not allow users to update" do
		    @ability = Ability.new(@user)
	      @ability.should_not be_able_to(:update, @widget)
	    end
    
	    it "should allow members to update" do
	      @user.set_canvas_role(@canvas, :member)
		    @ability = Ability.new(@user)
	      @ability.should be_able_to(:update, @widget)
	    end
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