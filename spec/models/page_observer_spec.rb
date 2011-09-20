require 'spec_helper'

describe PageObserver do
	
  context "page observer" do
	
		before :each do
			@page = Factory.build(:page)
			@pageObs = PageObserver.instance
		end
		
		it "should log an event when a new page is added" do			
      lambda do        
				@pageObs.after_create(@page)
      end.should change(Event, :count).by(1)
	  end

		it "should log an event when a page is updated" do
      lambda do        
				@pageObs.after_update(@page)
      end.should change(Event, :count).by(1)
	  end
  end

end
