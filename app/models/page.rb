class Page < ActiveRecord::Base

  belongs_to :canvas
  belongs_to :creator, :class_name => "User"
	has_many :widgets
		
  validates_presence_of :title
  validates_presence_of :creator
  validates_presence_of :canvas

  has_paper_trail
	
	# Return the versions of this page and its widgets ordered by date descending
  def all_versions
    Version.where("(item_type = \'Widget\' AND page_id = \'#{self.id}\') OR (item_type = \'Page\' AND item_id = \'#{self.id}\')").order("created_at DESC")
  end
	
end
