class Widget < ActiveRecord::Base
  
  belongs_to :page
  belongs_to :canvas
	belongs_to :creator, :class_name => "User"

  has_paper_trail :meta => { :page_id => Proc.new{ |widget| widget.page.id }}
    
  validates_presence_of :canvas
  validates_presence_of :creator
  
end
