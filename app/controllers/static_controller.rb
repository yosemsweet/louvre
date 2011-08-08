class StaticController < ApplicationController

	def index
		@recent_canvases = Canvas.recently_updated(10)
	end
	
	def test_widget
	  @widgets = Widget.all[0..2]
  end
	
end
