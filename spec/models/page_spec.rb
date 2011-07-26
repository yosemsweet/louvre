require 'spec_helper'

describe Page do
  context "Validations" do
		it "should be valid with valid parameters" do
			page = Factory.build(:page)
			page.should be_valid
		end
	
	  it "should save properly to the database" do
	    page = Factory.build(:page)
	    page.save!
	  end
	  
	  it "should be able to have widgets" do
	    Factory.build(:page).should respond_to(:widgets)
    end
	  
		context "attribute validations" do
			
			context "Title" do
				it "should be required" do
			  	page = Factory.build(:page, :title => "")
			    page.should_not be_valid
			  end
			end
			
			context "Creator" do
				it "should have a creator" do
					page = Factory.build(:page)
					page.should respond_to(:creator)
				end
				
				it "should be required" do
					page = Factory.build(:page, :creator => nil)
					page.should_not be_valid
				end
			end

			context "Canvas" do
				it "should have a canvas" do
					page = Factory.build(:page)
					page.should respond_to(:canvas)
				end

				it "should be required" do
					page = Factory.build(:page, :canvas => nil)
					page.should_not be_valid
				end
			end

		end
	
	end
	
	describe "#versions" do
	  
	  before(:each) do
	    @page = Factory.create(:page)
    end
	  
	  describe "A new page" do
	    it "shouldn't have any versions" do
	      @page.should have_exactly(0).versions
      end
    end
	  
	  describe "Adding a widget" do
	    it "should create a new page version" do
	      widget = Factory.create(:widget, :page => @page)
	      @page.should have_exactly(1).versions
      end
    end
    
    describe "Updating the title" do
      it "should create a new page version" do
        @page.update_attributes(:title => "New Title")
        @page.should have_exactly(1).versions
      end
    end
  end
	
end
