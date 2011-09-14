describe "canvae/members.html.haml" do
  before(:each) do
    @canvas = Factory.create(:canvas)
		Factory.create(:user).set_canvas_role(@canvas, :member)
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

		context "#member-list" do
			it "exists" do
				render
				rendered.should have_selector('#member-list')
			end
			
			it "contains all members each identified with data-user_id and a user class" do
				Factory.create(:user, :name=>"test member").set_canvas_role(@canvas, :member)
				render
				@canvas.members.each do |member|
					rendered.should have_selector("#member-list .user[data-user_id='#{member.user.id}']")
				end
			end
			
			it "has a ban link associated with each member" do
				render
				@canvas.members.each do |member|
					rendered.should have_selector("#member-list .user[data-user_id='#{member.user.id}']") do |m|
						m.should have_link("a.ban")
					end
				end
			end
		end
	end
end