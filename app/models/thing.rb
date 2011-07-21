class Thing < ActiveRecord::Base
  belongs_to :canvas
  belongs_to :creator, :class_name => "User"
  
  validates :canvas, :presence => true
  validates :creator, :presence => true
  validates :content, :presence => true
end
