require 'spec_helper'

describe DiscussionsController do
  describe 'GET show' do
    let (:canvas) {Factory.create(:canvas)}
    
    it "should respond with 200" do
      get :show, :type => 'canvas', :id => canvas.id
    end
    
    
    it "should set @obj" do
       get :show, :type => 'canvas', :id => canvas.id
       assigns(:obj).id.should == canvas.id
    end
  end
end