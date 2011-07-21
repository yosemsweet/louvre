class Comment < ActiveRecord::Base
  belongs_to :thing
  belongs_to :creator, :class_name => 'User'
  
  validates :thing, :presence => true
  validates :creator, :presence => true
  validates :content, :presence => true  
end
