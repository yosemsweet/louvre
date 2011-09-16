RSpec::Matchers.define :require_authorization_for do |method, action, options, role_symbol|
  match do |controller|
		User.any_instance.stubs(:persisted?).returns(true)
		controller.stubs(:current_user).returns(User.new)
		
		@error = {}
		
		having_role = succeed_with_role(method, action, options, role_symbol)
		not_having_role = fails_without_role(method, action, options, role_symbol)
		
		@error[:with_role] = "Could not perform ##{action} with #{role_symbol}" unless having_role
		@error[:without_role] = "Could perform ##{action} without #{role_symbol}" unless not_having_role
		
		having_role && not_having_role
  end

	def succeed_with_role(method, action, options, role_symbol)
		User.any_instance.stubs(:canvas_role).returns(role_symbol)
		
		response = self.send(method, action, options)
		response.status == 200
	end
	
	def fails_without_role(method, action, options, role_symbol)
		role = Role.new("unauthorized_role")
		role.stubs(:power).returns(Role.new(role_symbol).power - 1)
		User.any_instance.stubs(:canvas_role).returns(role)

		response = self.send(method, action, options)
		response.status == 403		
	end

  failure_message_for_should do |controller|
    "expected that #{method} #{controller.class}##{action} would require authorization level :#{role_symbol}\n#{@error.to_yaml}"
		
  end

  failure_message_for_should_not do |controller|
    "expected that #{method}  #{controller.class}##{action} would not require authorization level :#{role_symbol}\n#{@error.to_yaml}"
  end

  description do
    "#{method} #{action} with #{options} requires authorization level :#{role_symbol} on #{action} with #{options}"
  end
end