RSpec::Matchers.define :require_authorization_for do |method, action, options, role_symbol|
  match do |controller|
		controller.stubs(:current_user).returns(User.new)
		
		should succeed_with_role(method, action, options)
  end

	def succeed_with_role(method, action, options)
		User.any_instance.stubs(:role?).returns(true)

		self.send(method, action, options)
		puts response.to_yaml
		response.status.should == 302
	end

  failure_message_for_should do |controller|
    "expected that #{method} #{controller.class}##{action} would require authorization level :#{role_symbol}"
  end

  failure_message_for_should_not do |controller|
    "expected that #{method}  #{controller.class}##{action} would not require authorization level :#{role_symbol}"
  end

  description do
    "#{method} #{action} with #{options} requires authorization level :#{role_symbol} on #{action} with #{options}"
  end
end