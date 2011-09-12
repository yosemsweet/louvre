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
        @updated_widget = Factory.create(:text_widget)
        @updated_widget.update_attributes(:text => "New Content")
      end

      it "should create a new version" do
        @updated_widget.should have_exactly(2).versions
      end

      it "should save a changeset showing the change" do
        last_version = @updated_widget.versions.last
        last_version.should respond_to(:changeset)
        last_version.changeset["text"].last.should == "New Content"
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

	describe "#clone" do
		
		before(:each) do
			@original_widget = Factory.create(:widget, :page => nil)
			@cloned_widget = @original_widget.clone 
		end
		   
		it "cloned widget should have the same canvas, creator, content_type" do
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

    it "should get a new updated_at date" do
      @cloned_widget.save
      @cloned_widget.updated_at.should > @original_widget.updated_at
    end

		context "image widget" do
			it "should have the same alt text" do
				@original_image_widget = Factory.build(:image_widget, :alt_text => 'image alt text')
				@cloned_image_widget = @original_image_widget.clone
				@cloned_image_widget.alt_text.should == @original_image_widget.alt_text
			end
			
			it "should have the same image" do
				@original_image_widget = Factory.build(:image_widget, :image => 'image')
				@cloned_image_widget = @original_image_widget.clone
				@cloned_image_widget.image.should == @original_image_widget.image
			end
			
			it "should have the right content_type" do
			  @original_image_widget = Factory.build(:image_widget, :image => 'image')
				@cloned_image_widget = @original_image_widget.clone
				@cloned_image_widget.content_type.should == "image_content"
			end
		end
			
		context "text widget" do
			it "should have the same text" do
				@original = Factory.build(:text_widget, :text => 'text')
				@clone = @original.clone
				@clone.text.should == @original.text
			end
		end
		
	end
	
	describe "::random" do
		
		before(:each) do
			@random_widget = Factory.create(:widget)
		end
		
		it "should return a widget" do
			Widget.random.should == @random_widget
		end
		
	end
	
	describe "::for_page" do
	  it "returns the page's widgets ordered by position" do
	    page = Factory.create(:page)
	    w1 = Factory.create(:widget, :page => page, :position => 2)
	    w2 = Factory.create(:widget, :page => page, :position => 1)
	    
	    Widget.for_page(page.id).first.id.should == w2.id	    
    end
  end
  
  describe "::filter_by_tag_names" do
    
    before(:each) do
      @w1 = Factory.create(:widget)
      @w2 = Factory.create(:widget)
      @w3 = Factory.create(:widget)
      
      @t1 = Factory.create(:tag, :name => "first")
      @t2 = Factory.create(:tag, :name => "second")
      
      @w1.tags << @t1
      @w2.tags << @t2
    end
    
    it "should return widgets with matching tags" do
      Widget.filter_by_tag_names([@t1.name]).map(&:id).should include(@w1.id)
    end
    
    it "should not return widgets that don't match any of the tags" do
      widget_ids = Widget.filter_by_tag_names([@t1.name]).map(&:id)
      widget_ids.should_not include(@w2.id)
      widget_ids.should_not include(@w3.id)
    end
    
    it "should return all matching widgets for all tags passed" do
      widget_ids = Widget.filter_by_tag_names([@t1.name, @t2.name]).map(&:id)
      
      widget_ids.should include(@w1.id)
      widget_ids.should include(@w2.id)
      widget_ids.should_not include(@w3.id)
    end
    
    
  end

	context "widget types" do
		describe "text widgets" do
			before(:each) do
				@widget = Factory.build(:text_widget)
			end
			
			it "should have a content type of text_content" do
				@widget.content_type.should == "text_content"
			end
			
			it "should have text" do
		  	@widget.should respond_to(:text)
		  end
			
			it "should act as text" do
				@widget.text?.should == true
			end
		end
		
		describe "image widgets" do
			before(:each) do
				@widget = Factory.build(:image_widget)
			end
			
			it "should have a content type of image_content" do
				@widget.content_type.should == "image_content"
			end
			
			it "should require alt text" do
	      @widget.alt_text = nil
	      @widget.should_not be_valid
	    end
	
			it "should require an image" do
				@widget.image = nil
				@widget.should_not be_valid
			end
			
			it "should act as an image" do
				@widget.image?.should == true
			end
			
		end
		
		describe "link widgets" do
			before(:each) do
				@widget = Factory.build(:link_widget)
			end
			
			it "should have a content type of link_content" do
				@widget.content_type.should == "link_content"
			end
			
			it "should require a link" do
					@widget.link = nil
					@widget.should_not be_valid
			end
			
			it "should have a title" do
				@widget.should respond_to(:title)
			end
			
			it "should have a text" do
				@widget.should respond_to(:text)
			end
			
			it "should act as a link" do
				@widget.link?.should == true
			end
			
			
		end
	end
	
  # describe "#permalink" do
  #   
  #   it "should return the url for that widget" do
  #       widget = Factory.build(:text_widget)
  #       widget.permalink.should == "http://localhost:3000/widgets/#{widget.id}"
  #     end
  #   
  #   end

end
