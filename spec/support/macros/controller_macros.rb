module ControllerMacros 
	def should_render(template)
		it "should render the #{template} template" do 
			do_request 
			response.should render_template(template)
		end
	end

	def should_assign(hash) 
		variable_name = hash.keys.first 
		model, method = hash[variable_name] 
		model_access_method = [model, method].join('.') 
		
		it "should assign @#{variable_name} => #{model_access_method}" do
			expected = "the value returned by #{model_access_method}" 
			model.should_receive(method).and_return(expected) 
			do_request 
			assigns[variable_name].should == expected
		end 
	end
	
	def should_require_authentication(*args, &action)
		defaults = {:not_authenticated_status => 302, :not_authenticated_location => "auth"}.merge(args.extract_options!)
		options = defaults.merge(args.extract_options!)
		
		log_in
		action.call
		response.should_not return_status(options[:not_authenticated_status]).with_location(options[:not_authenticated_location])

		log_out
		action.call
		response.should return_status(options[:not_authenticated_status]).with_location(options[:not_authenticated_location])
	end
	
	def should_not_require_authentication(*args, &action)
		defaults = {:not_authenticated_status => 200}.merge(args.extract_options!)
		options = defaults.merge(args.extract_options!)
		
		log_in
		action.call
		response.should return_status(options[:not_authenticated_status])

		log_out
		action.call
		response.should return_status(options[:not_authenticated_status])
	end
	
	def should_require_authorization_to(*args, &action)
		defaults = {:action => :manage, :object => nil, :not_authorized_status => 403}.merge(args.extract_options!)
		options = defaults.merge(args.extract_options!)

		user = Factory.build(:user)
		user.stubs(:persisted?).returns(true)
    controller.stubs(:current_user).returns(user)

		authorize(options)
		action.call
		response.should_not return_status(options[:not_authorized_status])
		
		deauthorize(options)
		action.call
		response.should return_status(options[:not_authorized_status])
	end
	
	def should_not_require_authorization_to(*args, &action)
		defaults = {:action => :show,  :object => nil, :not_authorized_status => 200}.merge(args.extract_options!)
		options = defaults.merge(args.extract_options!)
		
		authorize(options)
		action.call
		response.should return_status(options[:not_authorized_status])

		deauthorize(options)
		action.call
		response.should return_status(options[:not_authorized_status])
	end
	
	private
	
	def log_in
		controller.stubs(:current_user).returns(User.new)
	end
	
	def log_out
		controller.stubs(:current_user).returns(nil)
	end
	
	def authorize(options)
		controller.current_ability.stubs(:can?).with(options[:action], options[:object]).returns(true)
	end
	
	def deauthorize(options)
	 	controller.current_ability.stubs(:can?).with(options[:action], options[:object]).returns(false)
	end
	
end

puts "Including Controller Macros"
RSpec.configure do |config|
	config.include(ControllerMacros, :type => :controller)
end