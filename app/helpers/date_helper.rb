module DateHelper
	
	def show_date(date_time)
		#TODO this should use actionview::datehelper::time_tag
		display_time = date_time >= 7.days.ago ? time_ago_in_words(date_time) : date_time.strftime("%b %d %Y %I:%M %p")
		%(<time datetime='#{date_time.to_s}'>#{display_time}</time>).html_safe
	end
	
end