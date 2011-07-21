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
      end
      
      describe "without valid params" do
      end
    end
   end
end