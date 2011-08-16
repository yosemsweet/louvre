module CanvaeHelper
	def bookmarklet(canvas, user)
		bookmarklet = <<-JS
				javascript:(function(){_my_var=document.createElement('SCRIPT');_my_var.type='text/javascript';_my_var.text='canvas_id=#{@canvas.id};user_id=#{user.id}';host_uri='#{host_uri}';_my_script=document.createElement('SCRIPT');_my_script.type='text/javascript';_my_script.src='#{host_uri}/javascripts/bookmarklet_dialog.js';element=document.getElementsByTagName('body')[0];element.appendChild(_my_var);element.appendChild(_my_script);})();
			JS
		bookmarklet.strip.html_safe	
	end
end
