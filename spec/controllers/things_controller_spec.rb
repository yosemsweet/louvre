require 'spec_helper'

describe ThingsController do

   describe "Post create" do
     
     #!describe "nested comments" do
      #! let(:thing) { Factory.build(:thing) }
       
     #!#!  before (:each) do
     #!   thing.comments.build({:creator => thing.creator, :content => 'test'})
     #!  end
       
    #!   it 'creates comments from parameters' do
     #!    post :create, 
     #!     :thing =>  {:content => thing.content, :creator_id => thing.creator.id, :comments => [{:content=>'hellow',:creator_id=>thing.creator.id}]},
     #!     :canvas_id => thing.canvas.id
     #!    assigns(:thing).comments.should_not be_empty
    #!  end
   #!  end
     
     describe "with json" do
      describe "with valid params" do
        let(:thing) { Factory.build(:thing) }
        
        it "assigns a newly created thing as @thing" do
          post :create, 
            :thing => {:content => thing.content, :creator_id => thing.creator.id}, 
            :format => 'json', 
            :canvas_id => thing.canvas.id
          assigns(:thing).content.should == thing.content and assigns(:thing).creator.should == thing.creator and assigns(:thing).canvas.should == thing.canvas
        end
        
        it "returns a success code" do
          results = post :create, 
            :thing => {:content => thing.content, :creator_id => thing.creator.id}, 
            :format => 'json', 
            :canvas_id => thing.canvas.id
          results.status.should == 201
        end
      end
      
      describe "without valid params" do
        let(:thing) { Factory.build(:thing, :content=>nil) }
        
        it "assigns new thing to @thing" do
          post :create, 
            :thing => {:content => thing.content, :creator_id => thing.creator.id}, 
            :format => 'json', 
            :canvas_id => thing.canvas.id
          assigns(:thing).id.should be_nil
        end
        
        it "returns an error code" do
          results = post :create, 
            :thing => {:content => thing.content, :creator_id => thing.creator.id}, 
            :format => 'json', 
            :canvas_id => thing.canvas.id
          results.status.should == 422
        end
      end
    end
  end
end