class Invite < ActiveRecord::Base
  belongs_to :canvas
	belongs_to :inviter, :class_name => "User"
    
  validates_presence_of :canvas, :inviter
end
