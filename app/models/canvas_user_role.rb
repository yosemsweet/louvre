class CanvasUserRole < ActiveRecord::Base
  belongs_to :canvas
  belongs_to :user
end
