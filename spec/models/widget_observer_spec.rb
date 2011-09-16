require 'spec_helper'

describe WidgetObserver do
	
  context "widget observer" do
	
		before :each do
			@widget = Factory.build(:widget)
			@widgetObs = WidgetObserver.instance
		end
		
		it "should log an event when a new widget is added" do
      lambda do        
				@widgetObs.after_create(@widget)
      end.should change(Event, :count).by(1)
	  end

		it "should log an event when a widget is updated" do
      lambda do        
				@widgetObs.after_update(@widget)
      end.should change(Event, :count).by(1)
	  end
	  
	  it "should not log an widget update event if only the position is updated" do
      page = Factory.create(:page)
			@widget_a = Factory.create(:widget, :position => 1, :page => page)
			@widget_a.update_position(5)
			
      lambda do
        @widgetObs.after_update(@widget_a)
      end.should change(Event, :count).by(0)
	  end
  end

end
