module KnowsBrowsingActivity
	def current_page
		@current_page ||= ""
	end
	
	def set_current_page(page)
		@current_page = page
	end
	
	def selection
		@current_page ||= ""
	end
	
	def set_selection(html)
		@selection = html
	end
	
	def input_stream_call_status
	  @input_stream_call_status ||= 404
	end
	
	def set_input_stream_call_status(status)
	  @input_stream_call_status = status
	end
	
	def host_uri
	  "http://loorp.local:3000"
	end
end

World(KnowsBrowsingActivity)