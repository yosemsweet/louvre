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
		end
	end
end