require 'spec_helper'

describe DiscussionsController do
  describe 'GET show' do
    let (:canvas) {Factory.create(:canvas)}
    
    it "should respond with 200" do
      get :show, :canvas_id => canvas.id
    end
    
    
    it "should set @canvas" do
       get :show, :canvas_id => canvas.id
       assigns(:canvas).id.should == canvas.id
    end
  end
end