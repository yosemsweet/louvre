require 'spec_helper'

describe 'shared/_menu.html.haml' do
  
  context "logged in" do
    before(:each) do
      @user = Factory.create(:user)
      view.stubs(:current_user).returns(@user)
  		view.controller.stubs(:current_user).returns(@user)
  		
  		controller.singleton_class.class_eval do
  		  helper_method :current_user
  		end
  	end
    
    it "should have a menu" do
      render :partial => "menu"
      rendered.should have_selector("#menubar")
    end
  
    context 'communities menu' do
      it "should exist" do
        render :partial => "menu"
        rendered.should have_selector("#canvae-menu")
      end
    
      context "current user has canvas_roles" do
        before(:each) do
          @member_canvas = Factory.create(:canvas)
          @user.set_canvas_role(@member_canvas, :member)
          
          @owner_canvas =  Factory.create(:canvas)
          @user.set_canvas_role(@owner_canvas, :owner)
        end 
        
        it "lists each canvas current_user has role in" do
          render :partial => "menu"
          @user.canvas_roles.each do |cur|
            rendered.should have_selector("#canvae-menu #canvas_#{cur.canvas.id}-menu a[href='#{canvas_path(cur.canvas)}']")
          end
        end
        
        it "adds an owner class to each canvas current user is an owner of" do
          render :partial => "menu"
          rendered.should have_selector("#canvae-menu #canvas_#{@owner_canvas.id}-menu.owner")
        end
        
        it "add a member class to each canvas current user is an member of" do
          render :partial => "menu"
          rendered.should have_selector("#canvae-menu #canvas_#{@member_canvas.id}-menu.member")
        end
        
        it "add a link to create a new canvas" do
            render :partial => "menu"
            rendered.should have_selector("#canvae-menu .new")  
        end
      end
    end
  end
  
  context "logged out" do
    before(:each) do
      view.stubs(:current_user).returns(nil)
  		view.controller.stubs(:current_user).returns(nil)
  	end
    it "should not render" do
      render :partial => "menu"
      rendered.should_not have_selector("#menubar")
    end
  end
end