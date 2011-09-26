require 'spec_helper'

describe PagesController do
	render_views

	describe "show" do
	  before(:each) do
	    @page = Factory(:page)
	  end
	
	  it "should be successful" do
	    get :show, :canvas_id => @page.canvas_id, :id => @page
	    response.should be_success
	  end
	
		it "should find the right page" do
	    get :show, :canvas_id => @page.canvas_id, :id => @page
	      assigns(:page).should == @page
		end
		
	    it "should have the right title & page heading" do
	    get :show, :canvas_id => @page.canvas_id, :id => @page
	      response.body.should have_selector("title", :content => @page.canvas.name)
	      response.body.should have_selector("h2", :content => @page.title)
	    end
	end
	
	  describe "GET 'new'" do
	  before(:each) do
	    @canvas = Factory(:canvas)
	    @user = Factory.create(:user)
	    PagesController.any_instance.stubs(:current_user).returns(@user)
			@user.set_canvas_role(@canvas,:member)
	  end
	
	    it "should be successful" do
	      get :new, :canvas_id => @canvas.id
	      response.should be_success
	    end
	    
	    it "should have the right title" do
	      get :new, :canvas_id => @canvas.id
	      response.body.should have_selector("title", :content => @canvas.name)
	    end
	    
	    it "should have a page title field" do
	      get :new, :canvas_id => @canvas.id
	      response.body.should have_selector('input[id="page_title"][name="page[title]"]')
	    end
	end
	
	
	  describe "POST 'create'" do
		before(:each) do
	    @canvas = Factory(:canvas)
	    @user = Factory.create(:user)
	    PagesController.any_instance.stubs(:current_user).returns(@user)
			@user.set_canvas_role(@canvas,:member)
		end
	
	    describe "failure" do
	      before(:each) do
	        @attr = { :title => "" }
	      end
	
	      it "should not create a page" do
	        lambda do
	          post :create, :canvas_id => @canvas.id, :page => @attr
	        end.should_not change(Page, :count)
	      end
	
	      it "should render the 'new' page" do
	        post :create, :canvas_id => @canvas.id, :page => @attr
	        response.should render_template('new')
	      end
	    end
		
	    describe "success" do
	      before(:each) do
	        @attr = { :title => "New Page" }
	      end
	
	      it "should create a page" do
	        post :create, :canvas_id => @canvas.id, :page => @attr
	        lambda do
	          post :create, :canvas_id => @canvas.id, :page => @attr
	        end.should change(Page, :count).by(1)	
	      end
	
	      it "should redirect to the page show page" do
	        post :create, :canvas_id => @canvas.id, :page => @attr
	        response.should redirect_to(edit_canvas_page_path(@canvas,assigns(:page)))
	      end 
	    end
	end
	
	  describe "GET 'edit'" do
	    before(:each) do
	    @page = Factory(:page)
	    @user = Factory.create(:user)
	    PagesController.any_instance.stubs(:current_user).returns(@user)
			@user.set_canvas_role(@page.canvas,:member)
	    end
	
	    it "should be successful" do
	      get :edit, :canvas_id => @page.canvas_id, :id => @page
	      response.should be_success
	    end
	
	    it "should have the right title" do
	      get :edit, :canvas_id => @page.canvas_id, :id => @page
	      response.body.should have_selector("title", :content => @page.canvas.name)
	    end
	
	    it "should have a page title field" do
	      get :edit, :canvas_id => @page.canvas_id, :id => @page
	      response.body.should have_selector('input[id="page_title"][name="page[title]"]')
	    end
	  end
	
	  describe "PUT 'update'" do
	
	    before(:each) do
	      @page = Factory(:page)
	    @user = Factory.create(:user)
	    PagesController.any_instance.stubs(:current_user).returns(@user)
			@user.set_canvas_role(@page.canvas,:member)
	    end
	
			# currently there is a problem with the redirect on a failing page update; need investigation
	    # describe "failure" do
	    # 
	    #   before(:each) do
	    #     @attr = { :title => "" }
	    #   end
	    # 
	    #   it "should render the 'edit' page" do
	    #     put :update, :canvas_id => @page.canvas_id, :id => @page, :page => @attr
	    # 				puts response.body
	    #     response.should render_template('edit')
	    #   end
	    # 
	    #   it "should have the right title" do
	    #     put :update, :canvas_id => @page.canvas_id, :id => @page, :page => @attr
	    #     response.body.should have_selector("title", :content => @page.canvas.name)
	    #   end
	    # 
	    # end
	
	    describe "success" do
	      before(:each) do
	        @attr = { :title => "New Title" }
	      end
	    
	      it "should change the user's attributes" do
	        put :update, :canvas_id => @page.canvas_id, :id => @page, :page => @attr
	        @page.reload
	        @page.title.should  == @attr[:title]
	      end
	    
	      it "should redirect to the page show page" do
	        put :update, :canvas_id => @page.canvas_id, :id => @page, :page => @attr
	        response.should redirect_to(canvas_page_path(@page.canvas, @page))
	      end
	    end
	
	  end
	
	  describe "DELETE 'destroy'" do
	    before(:each) do
	      @page = Factory(:page)
	    @user = Factory.create(:user)
	    PagesController.any_instance.stubs(:current_user).returns(@user)
			@user.set_canvas_role(@page.canvas,:member)
	    end
	
	    it "should destroy the page" do
	      lambda do
	        delete :destroy, :canvas_id => @page.canvas, :id => @page
	      end.should change(Page, :count).by(-1)
	    end
	
	    it "should redirect to the canvas page" do
	      delete :destroy, :canvas_id => @page.canvas, :id => @page
	      response.should redirect_to(canvas_path(@page.canvas))
	    end  
	  end
	
	context "put update" do
		
		describe "updating a page created by someone else" do
			before :each do
				@canvas = Factory.create(:canvas)
				
		    @user = Factory.create(:user)
				@user.set_canvas_role(@canvas,:member)
				
		   	PagesController.any_instance.stubs(:current_user).returns(@user)
		
				@creator = Factory.create(:user)
				@creator.set_canvas_role(@canvas,:member)
				
				@page = Factory.create(:page, :canvas => @canvas, :creator => @creator, :editor => @creator)

	      @attr = { :title => "New Text" }

	      put :update, :canvas_id => @canvas.id, :id => @page, :page => @attr
	
	      @page.reload
			end
			
			it "should update the page's editor" do
				@page.editor.should == @user
			end
			
			it "should not update page's creator" do
				@page.creator.should == @creator
			end
			
			it "creator and editor should be different people" do
				@page.creator.should_not == @page.editor
			end
			
		end
		
	end

end