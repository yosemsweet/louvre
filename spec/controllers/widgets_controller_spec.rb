require 'spec_helper'

describe WidgetsController do

   describe "Post create" do
     
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
          results.status.should == 200
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
		        results.status.should == 400
		      end
				end
	    end
    end
  end

  
end