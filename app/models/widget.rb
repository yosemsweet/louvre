class Widget < ActiveRecord::Base
  
  belongs_to :content, :polymorphic => true
  belongs_to :page
  belongs_to :canvas
  
  validates_presence_of :canvas
  
end
