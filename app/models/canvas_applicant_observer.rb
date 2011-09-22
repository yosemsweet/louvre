class CanvasApplicantObserver < ActiveRecord::Observer
  include ApplicationHelper

  def after_create(canvas_applicant)
    description = "#{canvas_applicant.applicant.name} has applied to the #{canvas_applicant.canvas.name} community"
    event = Event.create(:canvas_id => canvas_applicant.canvas_id, :user_id => canvas_applicant.user_id, :loggable_id => canvas_applicant.canvas_id, :loggable_type => 'Canvas', :description => description)
  end

end
