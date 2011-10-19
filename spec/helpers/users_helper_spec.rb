require 'spec_helper'

describe 'UsersHelper' do
	describe '#hint_for' do
		before(:each) do
		  @user = Factory.create(:user)
		  
			@canvas = Factory.create(:canvas, :creator => @user)
			@widget = Factory.create(:widget, :canvas => @canvas, :page => nil)
		end
		
		it "should respond to hint_for" do
			helper.should respond_to(:hint_for)
		end
		
		it "should accept 3 parameters, a canvas and a user, and a target" do
			helper.should respond_to(:hint_for).with(3).arguments

		end
		
    context "show canvas hint" do
      it "should show canvas hints for first time canvas creator" do
      	helper.hint_for(@canvas, @user, "canvas").should match("data-target='#canvas-settings")
      end

      it "should not show hints for users who have more than 1 canvas" do
        @canvas_two = Factory.create(:canvas, :creator => @user)	
        helper.hint_for(@canvas, @user, "canvas").should == ""
      end
    end
    
    context "show widget hint" do
      it "should show widget hints until updated" do
      	helper.hint_for(@canvas, @user, "widget").should include(%(data-target=".snippet[data-widget_id='#{@canvas.widgets.first.id}'] .tool.edit"))
      end

      it "should not show hints for creator who have more than 1 canvas" do
        @canvas_two = Factory.create(:canvas, :creator => @user)	
        helper.hint_for(@canvas, @user, "widget").should == ""
      end
      
      it "should not show hints for creator edited widgets" do
        
        @widget.updated_at = Time.now + 1.minute
        @widget.save	
        helper.hint_for(@canvas, @user, "widget").should == ""
      end
    end
    
    context "show page hint" do
      it "should show page hints until page is created" do
      	helper.hint_for(@canvas, @user, "page").should match("data-target='.add_page:first'")
      end

      it "should not show page hints for creator who have more than 1 canvas" do
        @canvas_two = Factory.create(:canvas, :creator => @user)	
        helper.hint_for(@canvas, @user, "page").should == ""
      end
      
      it "should not show hints for creator edited widgets" do
        @page = Factory.create(:page, :canvas => @canvas)	
        helper.hint_for(@canvas, @user, "page").should == ""
      end
    end
		
	end
end