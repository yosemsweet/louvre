module CanvaeHelper
	def bookmarklet(canvas, user)
		bookmarklet = <<-JS
				javascript:(function(){_my_var=document.createElement('SCRIPT');_my_var.type='text/javascript';_my_var.text='canvas_id=#{canvas.id};user_id=#{user.id}';host_uri='#{host_uri}';_my_script=document.createElement('SCRIPT');_my_script.type='text/javascript';_my_script.src='#{host_uri}/javascripts/bookmarklet_dialog.js';element=document.getElementsByTagName('body')[0];element.appendChild(_my_var);element.appendChild(_my_script);})();
			JS
		bookmarklet.strip
	end
	
	def bookmarklet_no_jquery(canvas, user)
		bookmarklet = <<-JS
				javascript:(function(){element=document.getElementsByTagName('body')[0];if(document.getElementById('loading')==null){_var_loading=document.createElement('div');_var_loading.id='loading';_var_loading.style.position='fixed';_var_loading.style.zIndex=10000;_var_loading.style.top='0';_var_loading.style.left='0';_var_loading.style.width='400px';_var_loading.style.paddingLeft='5px';_var_loading.style.backgroundColor='#111';_var_loading.style.color='#FFF';_var_loading.style.fontSize='20px';_var_loading.innerHTML='Loading Bookmarklet <img src=\\"#{host_uri}/images/loading-medium.gif\\"/>';element.appendChild(_var_loading);}_my_var=document.createElement('SCRIPT');_my_var.type='text/javascript';_my_var.text='canvas_id=#{canvas.id};user_id=#{user.id}';host_uri='#{host_uri}';_my_script=document.createElement('SCRIPT');_my_script.type='text/javascript';_my_script.src='#{host_uri}/javascripts/bookmarklet_dialog2.js?'+Math.floor(Math.random()*99999);element=document.getElementsByTagName('body')[0];element.appendChild(_my_var);element.appendChild(_my_script);})();
			JS
		bookmarklet.strip
	end
	
	def join_link_for(canvas, user)
		user ||= User.new
		unless user.canvas_role?(canvas, :member)
			if canvas.open?
				render :partial => "canvae/join", :object => canvas, :as => :canvas
			else
				render :partial => "canvae/apply", :object => canvas, :as => :canvas
			end
		else
			""
		end
	end
end