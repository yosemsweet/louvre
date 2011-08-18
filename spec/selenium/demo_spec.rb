require "spec_helper"

describe "my app" do
  it "should have a home page" do
      page.open "/"
    page.click "css=span.create-link"
    page.wait_for_page_to_load "30000"
    page.type "id=email", "marketing@suite101.com"
    page.type "id=pass", "yoda101"
    page.click "id=u942335_1"
    page.wait_for_page_to_load "30000"
    page.type "id=canvas_name", "testestest"
    page.type "id=canvas_mission", "test"
    page.click "id=canvas_submit"
    page.wait_for_page_to_load "30000"
    page.get_eval "javascript:(function(){_my_var=document.createElement('SCRIPT');_my_var.type='text/javascript';_my_var.text='canvas_id=8;user_id=1';host_uri='http://localhost:3000';_my_script=document.createElement('SCRIPT');_my_script.type='text/javascript';_my_script.src='http://localhost:3000/javascripts/bookmarklet_dialog.js';element=document.getElementsByTagName('body')[0];element.appendChild(_my_var);element.appendChild(_my_script);alert('hello1');})();"
	end
end
