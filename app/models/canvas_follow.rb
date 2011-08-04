class CanvasFollow < ActiveRecord::Base

  belongs_to :user
  belongs_to :canvas
  belongs_to :followed_canvas, :class_name => "Canvas", :foreign_key => "canvas_id"

end
