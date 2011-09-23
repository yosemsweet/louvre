class Page < ActiveRecord::Base

  belongs_to :canvas
  belongs_to :creator, :class_name => "User"
  belongs_to :editor, :class_name => "User"
	has_many :widgets
	has_many :events, :as => :loggable
	
  validates_presence_of :title, :creator, :editor, :canvas

  has_paper_trail
  acts_as_opengraph :values => { :type => "cause" }
	acts_as_followable

	def opengraph_image
  	canvas.image if canvas.present?
  end
	
	# Return the versions of this page and its widgets ordered by date descending
  def all_versions
    Version.where("(item_type = \'Widget\' AND page_id = \'#{self.id}\') OR (item_type = \'Page\' AND item_id = \'#{self.id}\')").order("created_at DESC")
  end
	
end
