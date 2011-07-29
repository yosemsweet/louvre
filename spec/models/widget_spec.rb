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

		it "should be able to have alt text" do
		  widget.should respond_to(:alt_text)
	  end
	
		it "should be able to have a content_type" do
			widget.should respond_to(:content_type)
		end
		
		it "should require a content type" do
			widget.content_type = nil
			widget.should_not be_valid
		end
		
		it "should have comments" do
			widget.should respond_to(:comments)
		end
		
		it "should support nested attributes for comments" do
			comments_attributes = [Factory.build(:comment).attributes.symbolize_keys ]
			expect {Factory(:widget, :comments_attributes => comments_attributes)}.to change(Comment, :count).by(1)
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
        @updated_widget.update_attributes(:content => "New Content")
      end

      it "should create a new version" do
        @updated_widget.should have_exactly(2).versions
      end

      it "should save a changeset showing the change" do
        last_version = @updated_widget.versions.last
        last_version.should respond_to(:changeset)
        last_version.changeset["content"].last.should == "New Content"
      end
    end

  end
  
	describe "#update_position" do
		
		before(:each) do
			page = Factory.create(:page)
			
			@widget_a = Factory.create(:widget, :position => 1, :page => page)
			@widget_b = Factory.create(:widget, :position => 2, :page => page)
			@widget_c = Factory.create(:widget, :position => 3, :page => page)
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
	
	describe "#position_last_on_page" do
		
		it "should set the position of a widget" do
			@new_widget = Factory.build(:widget, :position => nil)
			@new_widget.position_last_on_page
			@new_widget.save
			
			@new_widget.reload.position.should == 1
		end
		
	end
	
	describe "#remove_page_position" do
	  
	  before(:each) do
	    page = Factory.create(:page)
	    @widget_a = Factory.create(:widget, :position => 1, :page => page)
			@widget_b = Factory.create(:widget, :position => 2, :page => page)
			@widget_c = Factory.create(:widget, :position => 3, :page => page)
	    @widget_b.remove_page_position
		end

    it "should set the widget's position to nil" do
	    @widget_b.reload.position.should == nil
    end
	    
	  it "should adjust the widgets after its position up one" do
	    @widget_c.reload.position.should == 2
    end
	  
	  it "should not adjust the widgets before its position" do
	    @widget_a.reload.position.should == 1	  
    end

  end

	describe "#widget_clone" do
		
		before(:each) do
			@original_widget = Factory.create(:widget, :page => nil)
			@cloned_widget = @original_widget.widget_clone
			@cloned_widget.save 
		end
		   
		it "cloned widget should have the same content, canvas, creator, content_type" do
			@cloned_widget.content.should == @original_widget.content
			@cloned_widget.canvas.id.should == @original_widget.canvas.id
			@cloned_widget.creator.id.should == @original_widget.creator.id
			@cloned_widget.content_type.should == @original_widget.content_type
		end
		
		it "cloned widget id should be different to original widget id" do
			@cloned_widget.id.should_not == @original_widget.id
		end
		
		it "the original widget should be the parent of the cloned widget" do
			@cloned_widget.parent.id.should == @original_widget.id
		end

		it "cloned image widget should have alt text" do
			@original_image_widget = Factory.build(:image_widget, :alt_text => 'image alt text')
			@cloned_image_widget = @original_image_widget.widget_clone
			@cloned_image_widget.alt_text.should == @original_image_widget.alt_text
		end
		
	end
	

end
