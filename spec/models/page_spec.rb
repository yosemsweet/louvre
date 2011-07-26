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
	  
	  it "should have one version for a new page" do
	    @page.versions.length.should == 1
    end
	  
	  it "should have a new version when the page title is updated" do
	    @page.update_attributes(:title => "New Title")
	    @page.versions.length.should == 2
    end
    
  end
  
  describe "#all_versions" do
    
    before(:each) do
      @page = Factory.create(:page)
    end
    
    context "a new page" do
      it "should have one version" do
        @page.all_versions.length.should == 1
      end 
    end
    
    context "updating the title" do
      it "should add a new version" do
        @page.update_attributes(:title => "New Title")
  	    @page.all_versions.length.should == 2
      end 
    end
    
    context "adding a widget" do
      it "should add a new version" do
        Factory.create(:widget, :page => @page)
        @page.all_versions.length.should == 2
      end
    end
    
    context "in the wild" do
      
      before(:each) do
        # Create new page
        @page = Factory.create(:page)
        # Add two widgets to the page
        wa = Factory.create(:widget, :page => @page)
        wb = Factory.create(:widget, :page => @page)
        # Update the page title
        @page.update_attributes(:title => "New Title")
        # Add a third widget to the page
        @wc = Factory.create(:widget, :page => @page)
      end  
      
      it "should have the right number of versions" do
        @page.all_versions.length.should == 5
      end
      
      it "should list the earliest version last" do
        v = @page.all_versions.last
        v.item_type.should == "Page"
        v.event.should == "create"
      end
      
      it "should list the latest version first" do
        v = @page.all_versions.first
        v.item_type.should == "Widget"
      end
    end
  end
	
  # describe "#all_versions" do
  #   
  #   before(:each) do
  #     @page = Factory.create(:page)
  #     end
  #   
  #   describe "A new page" do
  #     it "shouldn't have any versions" do
  #       @page.all_versions.length.should == 0
  #       end
  #     end
  #   
  #   describe "Adding a widget" do
  #     it "should create a new page version" do
  #       widget = Factory.create(:widget, :page => @page)
  #       @page.all_versions.length.should == 1
  #       end
  #     end
  #     
  #     describe "Updating the title" do
  #       it "should create a new page version" do
  #         @page.update_attributes(:title => "New Title")
  #         @page.all_versions.length.should == 1
  #       end
  #     end
  #   end
	
end
