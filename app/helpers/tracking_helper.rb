require 'mixpanel_email.rb'

module TrackingHelper
	
  def track_email(body, canvas, user)
		api = MixpanelEmail.new(MIXPANEL_CONFIG[:token], 'invite/#{canvas}')
		tracked_email = api.add_tracking(user.id, body)
		return tracked_email
  end
  
end
