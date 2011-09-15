class CanvasApplicant < ActiveRecord::Base

  belongs_to :canvas

  #this is stupid, but it works
  belongs_to :applicant, :class_name => "User", :foreign_key => :user_id

end
