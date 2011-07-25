require 'spec_helper'

describe Widget do
  
  context "validations" do
  
    it "should be valid with valid attributes" do
      Factory.build(:widget).should be_valid
    end
  
    it "should be able to have a page" do
      Factory.build(:widget).should respond_to(:page)
    end
  
    it "should be able to have a canvas" do
      Factory.build(:widget).should respond_to(:canvas)
    end
  
    it "should require a canvas" do
      Factory.build(:widget, :canvas_id => nil).should_not be_valid
    end
    
    it "should be able to have a creator" do
      Factory.build(:widget).should respond_to(:creator)
    end
  
    it "should require a creator" do
      Factory.build(:widget, :creator_id => nil).should_not be_valid
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
  
	describe "#update_position" do
		
		before(:each) do
			@new_page = Factory.create(:page)
			
			@widget_a = Factory.create(:widget, :position => 1, :page => @new_page)
			@widget_b = Factory.create(:widget, :position => 2, :page => @new_page)
			@widget_c = Factory.create(:widget, :position => 3, :page => @new_page)
		end
		
		it "should update the position of this widget" do
			@widget_a.update_position(5)
			@widget_a.reload.position.should == 5
		end
		
		it "should adjust widget ordering correctly when moved down" do
			@widget_a.update_position(3)
			
			@widget_b.reload.position.should == 1
			@widget_c.reload.position.should == 2
		end
		
		it "should adjust widget ordering correctly when moved up" do
			@widget_c.update_position(1)
			
			@widget_a.reload.position.should == 2
			@widget_b.reload.position.should == 3
		end
		
		it "should return true if successful" do
			@widget_a = Factory.create(:widget, :position => 1)
			@widget_a.update_position(5).should be_true			
		end
		
	end
	
	describe "#initialize_position" do
		
		it "should set the position of a widget" do
			@new_widget = Factory.build(:widget, :position => nil)
			@new_widget.initialize_position
			@new_widget.save
			
			@new_widget.reload.position.should == 1
		end
		
	end

end
