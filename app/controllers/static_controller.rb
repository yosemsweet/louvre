class StaticController < ApplicationController

	def scrolly
		render :layout => "empty"
	end
	
	def scrolly2
		@widget = Widget.first
	end
	
end
