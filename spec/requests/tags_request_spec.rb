require "spec_helper"

describe "Tags Requests" do
  
  describe "GET /tags" do
    
    before(:each) do
      @tags = []
      1.upto(10) do |i|
        @tags << Factory.create(:tag, :name => "Tag #{i}")
      end
      @awesome_sauce_widget = Factory.create(:tag, :name => "AwesomeSauce")
      @tags << @awesome_sauce_widget
      get '/tags'
    end
    
    it "should work" do
      response.status.should == 200
    end
        
    context "when no query string is provided" do
      it "should render json for all the tags" do    
        response.body.should == @tags.map{|t| {:id => t.id, :name => t.name}}.to_json
      end
    end    
    
    context "when a query string is provided" do
      
      it "should only render json for the tags whose name matches the query" do
        get '/tags', {:q => "esomeSa"}
        response.body.should == [@awesome_sauce_widget].map{|t| {:id => t.id, :name => t.name}}.to_json
      end
      
    end    


    
  end
      
end