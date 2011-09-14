class CanvasUserRole < ActiveRecord::Base
  belongs_to :canvas
  belongs_to :user

	scope :banned, where(:role => :banned)
	scope :members, where(:role => :member)
	scope :not_banned, where("role <> ?", :banned)
end
