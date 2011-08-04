module SessionsHelper
	def login_link(options = {}, &block)
		options[:text] ||= "click here"
		script = <<-END
			<script>mpq.push(["track_links",$(".login-link"),"click_login"]);</script>
		END
		
		if block_given?
			content = capture(&block) 
			link = link_to("/auth/facebook", :class => "login-link") do
				concat content.html_safe
			end
		else
			link = link_to options[:text], "/auth/facebook", :class => "login-link"
		end
		
		content_tag(:span) do
			concat link
			concat script.html_safe
		end
	end
end
