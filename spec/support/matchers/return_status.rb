RSpec::Matchers.define :return_status do |expected|
  match do |actual|
		@errors = {}
		@actual = actual
			
		
		unless @actual.status == expected
			@errors[:status] = "expected status #{expected}, got #{actual.status}"
		end
		
		unless @location.nil?
			@actual.location ||= ""
			unless @actual.location.include?(@location) 
				@errors[:location] = "expect location to include #{@location}, got #{actual.location}"
			end
		end
		@errors.empty?
  end

	chain :with_location do |location|
		@location = location
	end
	
	failure_message_for_should do |actual|
    message = "expected actual.status to return #{expected}"
		message += " with actual.location of #{@location}" unless @location.nil?
		message += "\n#{@errors.to_yaml}" unless @errors.empty?
		message
  end

  failure_message_for_should_not do |actual|
    message = "expected actual.status to not return #{expected}"
		message += " with actual.location not including #{@location}" unless @location.nil?
		message += "\n#{@errors.to_yaml}" unless @errors.empty?
		message
  end

  description do
    message = "return status of #{expected}"
		message += "with location including #{@location}" unless @location.nil?
		message
  end
end