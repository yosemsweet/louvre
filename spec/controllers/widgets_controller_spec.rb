require 'spec_helper'

describe WidgetsController do

   describe "Post create" do
     
     #!describe "nested comments" do
      #! let(:widget) { Factory.build(:widget) }
       
     #!#!  before (:each) do
     #!   widget.comments.build({:creator => widget.creator, :content => 'test'})
     #!  end
       
    #!   it 'creates comments from parameters' do
     #!    post :create, 
     #!     :widget =>  {:content => widget.content, :creator_id => widget.creator.id, :comments => [{:content=>'hellow',:creator_id=>widget.creator.id}]},
     #!     :canvas_id => widget.canvas.id
     #!    assigns(:widget).comments.should_not be_empty
    #!  end
   #!  end
     
     describe "with json" do
      describe "with valid params" do
        let(:widget) { Factory.build(:widget) }
        
        it "assigns a newly created widget as @widget" do
          post :create, 
            :widget => {:content => widget.content, :creator_id => widget.creator.id, :content_type => widget.content_type}, 
            :format => 'json', 
            :canvas_id => widget.canvas.id
          assigns(:widget).content.should == widget.content and assigns(:widget).creator.should == widget.creator and assigns(:widget).canvas.should == widget.canvas
        end
        
        it "returns a success code" do
          results = post :create, 
            :widget => {:content => widget.content, :creator_id => widget.creator.id,  :content_type => widget.content_type}, 
            :format => 'json', 
            :canvas_id => widget.canvas.id
          results.status.should == 201
        end
      end
      
      describe "without valid params" do
				context "missing content type" do
		      let(:widget) { Factory.build(:widget, :content_type=>nil) }
      
		      it "assigns new widget to @widget" do
		        post :create, 
		          :widget => {:content => widget.content, :creator_id => widget.creator.id,  :content_type => widget.content_type}, 
		          :format => 'json', 
		          :canvas_id => widget.canvas.id
		        assigns(:widget).id.should be_nil
		      end
      
		      it "returns an error code" do
		        results = post :create, 
		          :widget => {:content => widget.content, :creator_id => widget.creator.id,  :content_type => widget.content_type}, 
		          :format => 'json', 
		          :canvas_id => widget.canvas.id
		        results.status.should == 406
		      end
				end
	    end
    end
  end
  
  describe "Post clone_widget" do
    
    it "clones the passed in widget" do
      widget = FactoryGirl.create(:widget)
      Widget.stub(:find).and_return(widget)
      widget.should_receive(:clone).and_return(Widget.new(widget.attributes.update :updated_at => nil, :created_at => nil, :position => nil, :parent => widget))
      post :clone_widget,
        :id => widget.id,
        :canvas_id => widget.canvas.id,
        :page_id => FactoryGirl.create(:page),
        :position => 1
    end

    it "adds the widget to the page" do
      pending
    end

  end

  
end