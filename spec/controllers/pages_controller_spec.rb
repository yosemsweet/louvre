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
		    @canvas = Factory(:canvas)
		    @user = Factory.create(:user)
		    PagesController.any_instance.stubs(:current_user).returns(@user)
				@user.set_canvas_role(@canvas,:member)
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

      # it "should redirect to the page show page" do
      #   post :create, :canvas_id => @canvas.id, :page => @attr
      #   response.should redirect_to(canvas_page_path(assigns(:page)))
      # end 
    end

	end

end