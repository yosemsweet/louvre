module KnowsBrowsingActivity
	def current_page
		@current_page ||= ""
	end
	
	def set_current_page(page)
		@current_page = page
	end
end

World(KnowsBrowsingActivity)