describe "canvae/banned.html.haml" do
  before(:each) do
    @canvas = Factory.create(:canvas)
		Factory.create(:user).set_canvas_role(@canvas, :banned)
  end
  
	context "logged in" do
	  before do
			user = Factory.create(:user)
	    controller.singleton_class.class_eval do
	      private
	        def current_user
	           user
	        end
	        helper_method :current_user
	    end
	  end

		context "#ban-list" do
			it "exists" do
				render
				rendered.should have_selector('#ban-list')
			end
			
			context "with banned members" do
				before(:each) do
					Factory.create(:user, :name =>"test member 1").set_canvas_role(@canvas, :banned)
					Factory.create(:user, :name=>"test member 2").set_canvas_role(@canvas, :banned)
				end
				
				it "contains all banned users each identified with data-user_id and a user class" do
					render
					@canvas.banned.each do |banned|
						rendered.should have_selector("#ban-list .user[data-user_id='#{banned.user.id}']")
					end
				end
			
				it "has an unban link for each user identified with data" do
					render
					@canvas.banned.each do |banned|
						rendered.should have_selector("a.unban[data-user_id='#{banned.user.id}']")
					end
				end
			end
		end
	end
end