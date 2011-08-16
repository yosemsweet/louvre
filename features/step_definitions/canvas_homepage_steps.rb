Then /^I can install the canvas bookmarklet$/ do
  bookmarklet = "javascript:(function(){_my_var=document.createElement('SCRIPT');_my_var.type='text/javascript';_my_var.innerText='canvas_id=#{Canvas.last.id};user_id=#{current_user.id}';_my_script=document.createElement('SCRIPT');_my_script.type='text/javascript';_my_script.src='#{host_uri}/javascripts/post-link.js';element=document.getElementsByTagName('body')[0];element.appendChild(_my_var);element.appendChild(_my_script);})();"
  
	puts page.find("a#bookmarklet")[:href]

	page.should have_selector( "a#bookmarklet[href='#{bookmarklet}]") do |link|
    link.should have_content("Add to #{Canvas.last.name}")
  end
end