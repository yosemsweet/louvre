require 'spec_helper'

describe CommentsController do

   describe "Post create" do
    describe "with json" do
      describe "with valid params" do
        let(:comment) { Factory.build(:comment) }
        
        it "assigns a newly created comment as @comment" do
          post :create, 
            :comment => {:content => comment.content, :creator_id => comment.creator.id}, 
            :format => 'json', 
            :canvas_id => comment.thing.canvas.id, 
            :thing_id => comment.thing.id
          assigns(:comment).content.should == comment.content and assigns(:comment).creator.should == comment.creator and assigns(:comment).thing.should == comment.thing
        end
        
        it "returns a success code" do
          results = post :create, 
            :comment => {:content => comment.content, :creator_id => comment.creator.id}, 
            :format => 'json', 
            :canvas_id => comment.thing.canvas.id, 
            :thing_id => comment.thing.id
          results.status.should == 201
        end
      end
      
      describe "without valid params" do
        let(:comment) { Factory.build(:comment, :content=>nil) }
        
        it "assigns new comment to @comment" do
          post :create, 
            :comment => {:content => comment.content, :creator_id => comment.creator.id}, 
            :format => 'json', 
            :canvas_id => comment.thing.canvas.id, 
            :thing_id => comment.thing.id
          assigns(:comment).id.should be_nil
        end
        
        it "returns an error code" do
          results = post :create, 
            :comment => {:content => comment.content, :creator_id => comment.creator.id}, 
            :format => 'json', 
            :canvas_id => comment.thing.canvas.id, 
            :thing_id => comment.thing.id
          results.status.should == 422
        end
      end
    end
   end
end