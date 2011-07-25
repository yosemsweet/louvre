require 'spec_helper'

describe Widget do
  
  context "validations" do
  	let(:widget ) { Factory.build(:widget) }


    it "should be valid with valid attributes" do
      widget.should be_valid
    end
  
    it "should be able to have a page" do
      widget.should respond_to(:page)
    end
  
    it "should be able to have a canvas" do
      widget.should respond_to(:canvas)
    end
  
    it "should require a canvas" do
			widget.canvas = nil
      widget.should_not be_valid
    end
    
    it "should be able to have a creator" do
      widget.should respond_to(:creator)
    end
  
    it "should require a creator" do
			widget.creator = nil
      widget.should_not be_valid
    end

		it "should be able to have content" do
	  	widget.should respond_to(:content)
	  end
	
		it "should be able to have a content_type" do
			widget.should respond_to(:content_type)
		end
		
		it "should require a content type" do
			widget.content_type = nil
			widget.should_not be_valid
		end
  end
  
  describe "Versioning" do
    
    describe "Creation" do
      
      before(:each) do
        @new_widget = Factory.create(:widget)
      end
        
      it "should create a new version" do
        @new_widget.should have_exactly(1).versions
      end
      
      it "should store the page id in version meta data" do
        @new_widget.versions.last.page_id.should == @new_widget.page.id 
      end
      
    end
    
    describe "Updating" do
      before(:each) do
        @updated_widget = Factory.create(:widget)
        @updated_widget.update_attributes(:name => "New Name")
      end

      it "should create a new version" do
        @updated_widget.should have_exactly(2).versions
      end

      it "should save a changeset showing the change" do
        last_version = @updated_widget.versions.last
        last_version.should respond_to(:changeset)
        last_version.changeset["name"].last.should == "New Name"
      end
    end
    
  end
  
end
