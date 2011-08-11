require "spec_helper"

describe "Tags Requests" do
  
  describe "GET /tags" do
    
    before(:each) do
      @tags = []
      1.upto(10) do |i|
        @tags << Factory.create(:tag, :name => "Tag #{i}")
      end
      get '/tags'
    end
    
    it "should work" do

      response.status.should == 200
    end
        
    it "should render all the tag ids as json" do    
      response.body.should == @tags.map(&:id).to_json
    end
    
  end
      
end