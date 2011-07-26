class Widget < ActiveRecord::Base
  
  belongs_to :page
  belongs_to :canvas
	belongs_to :creator, :class_name => "User"
	
	has_many :comments

  has_paper_trail :meta => { :page_id => Proc.new{ |widget| widget.page ? widget.page.id : nil }}
    
  validates_presence_of :canvas, :creator, :content_type  
end
