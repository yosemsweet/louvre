require 'spec_helper'

describe WidgetsController do

   describe "Post create" do
     describe "text widget" do
     	describe "with json" do
	      describe "with valid params" do
	        let(:widget) { Factory.build(:text_widget) }
        
	        it "assigns a newly created widget as @widget" do
	          post :create, 
	            :widget => {:text => widget.text, :creator_id => widget.creator.id, :content_type => widget.content_type}, 
	            :format => 'json', 
	            :canvas_id => widget.canvas.id
	          assigns(:widget).text.should == widget.text and assigns(:widget).creator.should == widget.creator and assigns(:widget).canvas.should == widget.canvas
	        end
        
	        it "returns a success code" do
						widget.creator.set_canvas_role(widget.canvas,:member)
				    WidgetsController.any_instance.stubs(:current_user).returns(widget.creator)
	          results = post :create, 
	            :widget => {:text => widget.text, :creator_id => widget.creator.id,  :content_type => widget.content_type}, 
	            :format => 'json', 
	            :canvas_id => widget.canvas.id
	          results.status.should == 201
	        end
	      end
	    end
	
			describe "image widget" do
	     	describe "with json" do
		      describe "with valid params" do
		        let(:widget) { Factory.build(:image_widget) }

		        it "assigns a newly created widget as @widget" do
		          post :create, 
		            :widget => {:image => widget.image, :alt_text => widget.alt_text, :creator_id => widget.creator.id, :content_type => widget.content_type}, 
		            :format => 'json', 
		            :canvas_id => widget.canvas.id
		          assigns(:widget).image.should == widget.image and assigns(:widget).alt_text.should == widget.alt_text and assigns(:widget).creator.should == widget.creator and assigns(:widget).canvas.should == widget.canvas
		        end

		        it "returns a success code" do
							widget.creator.set_canvas_role(widget.canvas,:member)
					    WidgetsController.any_instance.stubs(:current_user).returns(widget.creator)
		          results = post :create, 
								:widget => {:image => widget.image, :alt_text => widget.alt_text, :creator_id => widget.creator.id, :content_type => widget.content_type}, 
		            :format => 'json', 
		            :canvas_id => widget.canvas.id
		          results.status.should == 201
		        end
		      end
		    end
			end
	
			describe "without valid params" do
				context "missing content type" do
		      let(:widget) { Factory.build(:widget, :content_type=>nil) }
     
		      it "assigns new widget to @widget" do
		        post :create, 
		          :widget => {:creator_id => widget.creator.id,  :content_type => widget.content_type}, 
		          :format => 'json', 
		          :canvas_id => widget.canvas.id
		        assigns(:widget).id.should be_nil
		      end
     
		      it "returns an error code" do
						widget.creator.set_canvas_role(widget.canvas,:member)
				    WidgetsController.any_instance.stubs(:current_user).returns(widget.creator)
		        results = post :create, 
		          :widget => {:creator_id => widget.creator.id,  :content_type => widget.content_type}, 
		          :format => 'json', 
		          :canvas_id => widget.canvas.id
		        results.status.should == 400
		      end
				end
	    end
	
		end
  end

  
end