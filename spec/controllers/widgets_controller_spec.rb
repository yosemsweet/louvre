require 'spec_helper'

describe WidgetsController do
	
  before(:each) do
    @user = Factory.create(:user)
    WidgetsController.any_instance.stubs(:current_user).returns(@user)
  end

   describe "Post create" do
     describe "text widget" do
     	describe "with json" do
	      describe "with valid params" do
	        let(:widget) { Factory.build(:text_widget) }
        
	        it "assigns a newly created widget as @widget" do
	          post :create, 
	            :widget => {:text => widget.text, :content_type => widget.content_type}, 
	            :format => 'json', 
	            :canvas_id => widget.canvas.id
	          assigns(:widget).text.should == widget.text and assigns(:widget).creator.should == @user and assigns(:widget).editor.should == @user and assigns(:widget).canvas.should == widget.canvas
	        end
        
	        it "returns a success code" do
						@user.set_canvas_role(widget.canvas,:member)
	          results = post :create, 
	            :widget => {:text => widget.text, :content_type => widget.content_type}, 
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
		            :widget => {:image => widget.image, :alt_text => widget.alt_text, :content_type => widget.content_type}, 
		            :format => 'json', 
		            :canvas_id => widget.canvas.id
		          assigns(:widget).image.should == widget.image and assigns(:widget).alt_text.should == widget.alt_text and assigns(:widget).creator.should == @user and assigns(:widget).editor.should == @user and assigns(:widget).canvas.should == widget.canvas
		        end

		        it "returns a success code" do
							@user.set_canvas_role(widget.canvas,:member)
		          results = post :create, 
								:widget => {:image => widget.image, :alt_text => widget.alt_text, :content_type => widget.content_type}, 
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
		          :widget => {:creator_id => widget.creator.id, :editor_id => widget.editor.id,  :content_type => widget.content_type}, 
		          :format => 'json', 
		          :canvas_id => widget.canvas.id
		        assigns(:widget).id.should be_nil
		      end
     
		      it "returns an error code" do
						@user.set_canvas_role(widget.canvas,:member)
		        results = post :create, 
		          :widget => {:creator_id => widget.creator.id, :content_type => widget.content_type}, 
		          :format => 'json', 
		          :canvas_id => widget.canvas.id
		        results.status.should == 400
		      end
				end
	    end
	
		end
  end
	
	context "put update" do
		
		describe "updating a widget created by someone else" do
			before :each do
				@canvas = Factory.create(:canvas)
				
				@creator = Factory.create(:user)
				@creator.set_canvas_role(@canvas,:member)
				@user.set_canvas_role(@canvas,:member)
				
				@widget = Factory.create(:widget, :canvas => @canvas, :creator => @creator, :editor => @creator)
				@widget.save!

	      @attr = { :text => "New Text" }
	      put :update, :id => @widget.id, :widget => @attr
	      @widget.reload
			end
			
			it "should update the widget's editor" do
				@widget.editor.should == @user
			end
			
			it "should not update widget's creator" do
				@widget.reload.creator.should == @creator
			end
			
			it "creator and editor should be different people" do
				@widget.reload.creator.should_not == @widget.reload.editor
			end
			
		end
		
	end

  
end