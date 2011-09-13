require "spec_helper"

describe "Widgets Requests" do
  
  before(:each) do
    @user = Factory.create(:user)
    # Stub the current_user method so it appears like a user is logged in.
    WidgetsController.any_instance.stubs(:current_user).returns(@user)
  end
  
  describe "POST /widgets/[widget_id]/copy_to_page/[page_id]" do
    
    context "non question widget" do
    
      before(:each) do
        canvas = Factory.create(:canvas)
        @page = Factory.create(:page)  
        @widget = Factory.create(:text_widget, :canvas => canvas, :page_id => nil, :text => "Happy Feet")
        post "/widgets/#{@widget.id}/copy_to_page/#{@page.id}", :position => 1
        @latest_widget = Widget.last
      end
    
      it "should create a new widget" do
        Widget.all.length.should == 2
        @latest_widget.id.should_not == @widget.id
      end
    
      it "should copy the cloned widget's content" do
        @latest_widget.text.should == @widget.text
      end
      
      it "should set the new widget's page" do
        @latest_widget.page_id.should == @page.id
      end
    
      it "should set the new widget's position" do
        @latest_widget.position.should == 1
      end
    
    end
    
    context "question widget" do
      before(:each) do
        canvas = Factory.create(:canvas)      
        @widget = Factory.create(:question_widget, :canvas => canvas, :page_id => nil)
        Widget.any_instance.stubs(:comments).returns(["first comment", "second comment"])
        @page = Factory.create(:page, :canvas => canvas)
        post "/widgets/#{@widget.id}/copy_to_page/#{@page.id}", :position => 1 
      end
      
      it "should include the comments in the answer" do
        answer = @page.widgets.first.answer
        answer.should include("first comment")
        answer.should include("second comment")
      end
    end
  end
 
  describe "POST /widgets/create_via_email/" do
    
    before(:each) do
      @canvas = Factory.create(:canvas)
      email = Factory.create(:email, :user_id => @user.id)
    end
    
    it "should create a new widget" do
      post "/widgets/create_via_email/",
        :to => @canvas.id.to_s + '@feed.loorp.com', :from => @user.emails.first.address, :text => 'This is the content of the email'
      Widget.last.text.should == 'This is the content of the email'
      response.status.should == 201
    end
    
  end
  
    describe "PUT /widgets/[widget_id]/move/[position]" do
      
      before(:each) do
        canvas = Factory.create(:canvas)
        p = Factory.create(:page)  
        @w1 = Factory.create(:widget, :canvas => canvas, :page_id => p.id, :position => 1)
        @w2 = Factory.create(:widget, :canvas => canvas, :page_id => p.id, :position => 2)
        put "/widgets/#{@w2.id}/move/1"
      end
      
      it "should update the widget's position" do
        @w2.reload.position.should == 1
      end
      
      it "should update the position of other widgets on the page appropriately" do
        @w1.reload.position.should == 2
      end
      
    end
    
    describe "DELETE /widgets/[widget_id]" do
      
      before(:each) do
        canvas = Factory.create(:canvas)
        widget = Factory.create(:widget, :canvas => canvas, :position => 1)
        delete "/widgets/#{widget.id}"
      end
      
      it "should delete the widget" do
        Widget.all.length.should == 0
      end
      
    end
  
  describe "GET /widgets" do
    
    before(:each) do
      canvas = Factory.create(:canvas)
      @widgets = []
      10.times do |i|
        @widgets << Factory.create(:text_widget, :canvas => canvas, :page => nil, :text => "#{i}")
      end       
      get "/widgets"
    end
    
    it "should render html for 10 widgets" do
      response.body.should have_css(".widget", :count => 10)
    end
    
    it "should work" do
        response.status.should be(200)
    end
        
  end
  
  describe "GET /widgets/for_page/[page_id]/editable" do
      
      before(:each) do
        canvas = Factory.create(:canvas)
        page = Factory.create(:page)
        @w1 = Factory.create(:text_widget, :canvas => canvas, :page => page, :position => 1, :text => "FirstGuy")
        @w2 = Factory.create(:text_widget, :canvas => canvas, :page => page, :position => 2, :text => "IAmLast")
        get "/widgets/for_page/#{page.id}/editable"
      end
      
      it "should work" do
        response.status.should == 200
      end
      
      it "should render the widgets for the page" do
        response.body.should have_css(".widget", :count => 2)
      end
      
      it "should list the widgets in order of position" do
        css_select(".widget .content").first.should match(/FirstGuy/)
        css_select(".widget .content").last.should match(/IAmLast/)
      end
      
    end
    
    describe "GET /widgets/for_canvas/[id]/canvas_feed" do
  
      before(:each) do
        @canvas = Factory.create(:canvas)
        @page = Factory.create(:page)
      end
  
      context "with no tag_names filter" do
  
        before(:each) do
          @w_on_page = Factory.create(:text_widget, :canvas => @canvas, :page => @page, :text => "Happy Feet")
          @w_not_on_page = Factory.create(:text_widget, :canvas => @canvas, :page => nil, :text => "Hungry Almas")
          get "/widgets/for_canvas/#{@canvas.id}/canvas_feed"
        end
  
        it "should work" do
          response.status.should be(200)
        end
  
        it "renders the widgets on the canvas" do
          response.body.should include(@w_not_on_page.text)  
        end
      
        it "doesn't render any widgets that are on a page" do
          response.body.should_not include(@w_on_page.text)  
        end
        
      end
      
      context "with tag_names filter" do
        
        before(:each) do
          @tag = Factory.create(:tag, :name => "MyTag")
          @tagged_widget = Factory.create(:text_widget, :text => "Tagged", :canvas => @canvas, :page => nil)
          @untagged_widget = Factory.create(:text_widget, :text => "NoneOfEm", :canvas => @canvas, :page => nil)
          
          @tagged_widget.tags << @tag
          
          get "/widgets/for_canvas/#{@canvas.id}/canvas_feed", {:tag_names => @tag.name}
        end
        
        it "should get tagged widgets" do
          response.body.should include(@tagged_widget.text)
        end
        
        it "should not get untagged widgets" do
          response.body.should_not include(@untagged_widget.text)
        end
        
      end
      
      context "with empty tag_names filter" do
        before(:each) do
          @widget = Factory.create(:text_widget, :text => "Tagged", :canvas => @canvas, :page => nil)
          get "/widgets/for_canvas/#{@canvas.id}/canvas_feed", {:tag_names => ""}
        end
        
        it "should not filter the widgets" do
          response.body.should include(@widget.text)
        end
        
      end
      
    end
    
    
    describe "PUT /widgets/[widget_id]/remove_answer/[answer_id]" do
      
      before :each do
        @answer = [
          { :message => "This is an answer.", :commenter => "Bob Dylan", :comment_date => 15.minutes.ago },
          { :message => "Another one.", :commenter => "James Dean", :comment_date => 7.hours.ago }
        ].to_json
        @widget = Factory.create(:question_widget, :answer => @answer)
      end
      
      it "should work" do
        put "/widgets/#{@widget.id}/remove_answer/0"
        response.status.should be(200)
      end
      
      it "should remove the answer" do
        put "/widgets/#{@widget.id}/remove_answer/0"
        @widget.reload.answers.length.should == 1
        @widget.reload.answers.first["message"].should == "Another one."
      end
    end
    
    context "closed canvas" do
     describe "not logged in as a member" do
       before :each do
         @canvas = Factory.create(:canvas)
         get "/canvae/#{@canvas.id}"
       end
  
      it "should not show bookmarklet link" do
        response.body.should_not include("id='bookmarklet'")
      end
 
       it "should not show the email" do
         response.body.should_not include("Easily add content to the feed by sending an email to this address:")
       end
 
       it "should not show add any add a widget link" do
         response.body.should_not include("id='toolbar'")
         response.body.should_not include("class='add_widget'")
       end
 
       it "should not show the edit button on widget"
   
     end

		describe "logged in as a member" do
    	before :each do
				@canvas = Factory.create(:canvas)
				@user.set_canvas_role(@canvas,:member)
				# Stub the current_user method so it appears like a user is logged in.
				CanvaeController.any_instance.stubs(:current_user).returns(@user)
				get "/canvae/#{@canvas.id}"
       end
   
       it "should show bookmarklet link" do
         response.body.should include("id='bookmarklet'")
       end
 
       it "should show the email" do
         response.body.should include("Easily add content to the feed by sending an email to this address:")
       end
 
       it "should show add all add a widget link" do
         response.body.should include("id='toolbar'")
         response.body.should include("class='add_widget'")
       end
 
       it "should show the edit button on widget"
    end
	end
	
end