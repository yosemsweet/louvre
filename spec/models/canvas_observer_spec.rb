require 'spec_helper'

describe CanvasObserver do
	
  context "canvas observer" do
	
		before :each do
			@canvas = Factory.create(:canvas)
			@canvasObs = CanvasObserver.instance
		end
		
		it "should log an event when a new canvas is added" do			
      lambda do        
				@canvasObs.after_create(@canvas)
      end.should change(Event, :count).by(1)
	  end

		it "should log an event when a new canvas is updated" do
      lambda do        
				@canvasObs.after_update(@canvas)
      end.should change(Event, :count).by(1)
	  end
  end

end
