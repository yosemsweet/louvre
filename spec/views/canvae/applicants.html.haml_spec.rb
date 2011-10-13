describe "canvae/applicants.html.haml" do
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

		context "#applicant-list" do
			it "exists" do
				render
				rendered.should have_selector('#applicant-list')
			end
			
			context "with applicants" do
				before(:each) do
					@canvas.canvas_applicants.create(:user_id => Factory.create(:user, :name=>"test applicant").id)
					@canvas.canvas_applicants.create(:user_id => Factory.create(:user, :name=>"test applicant 2").id)
				end
				
				it "contains all applicants each identified with data-user_id and a user class" do
					render
					@canvas.applicants.each do |applicant|
						rendered.should have_selector("#applicant-list .member-item[data-user_id='#{applicant.id}']")
					end
				end
			
				it "has a ban link associated with each applicant" do
					render
					@canvas.applicants.each do |applicant|
						rendered.should have_selector("a.ban")
					end
				end
			end
		end
	end
end