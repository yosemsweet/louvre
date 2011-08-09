class Widget < ActiveRecord::Base
  
  belongs_to :page
  belongs_to :canvas
	belongs_to :creator, :class_name => "User"
	belongs_to :parent, :class_name => "Widget"
	
	has_many :comments

	accepts_nested_attributes_for :comments

  has_paper_trail :meta => { :page_id => Proc.new{ |widget| widget.page ? widget.page.id : nil }}
  acts_as_opengraph :values => { :type => "cause" }
    
  validates_presence_of :canvas, :creator, :content_type
  validates_presence_of :alt_text, :if => :image?

  def self.site_feed
    widgets = []
		10.times do
			widgets << Widget.random
		end
		return widgets
  end
  
  def self.for_canvas(canvas_id)
    Canvas.find(canvas_id).widgets.where(:page_id => nil)
  end
  
  def self.for_page(page_id)
    Page.find(page_id).widgets.order("position asc")
  end

	def self.random
		total_widgets = Widget.all
		return total_widgets[rand(total_widgets.length)]
	end

  def image?
    content_type == 'image_content'
  end

	def update_position(new_position)
		
		old_position = self.position
		position_change = new_position.to_i - old_position
		
		if self.update_attributes({:position => new_position})

			if position_change > 0
				decrement_position_between(new_position,old_position)
			elsif position_change < 0
				increment_position_between(new_position,old_position)
			end
			
			return true
			
		else
			return false
		end
		
	end
	
	def insert_position(position)
		
		if self.update_attributes({:position => position})
			increment_after
		end
		
		return true
		
	end
	
	def position_last_on_page
		if self.page
			self.position = self.page.widgets.length + 1
		end
	end
	
	def remove_page_position
	  if self.page
	    decrement_after
	    update_attributes(:position => nil)
    end
  end
	
	def clone
	  Widget.new(self.attributes.update :updated_at => nil, :created_at => nil, :position => nil, :parent => self)
	end
	 
	private
	
	def decrement_before
	  # Decrement all earlier placements on this page.
		ActiveRecord::Base.connection.execute(<<SQL
			UPDATE widgets SET
			 position = position - 1
			WHERE page_id = #{self.page.id}
			  AND position <= #{self.position}
			  AND id <> #{self.id}
SQL
		)
	end
	
	def increment_after
	  # Incremement all later placements on this page.   
	  ActiveRecord::Base.connection.execute(<<SQL
	    UPDATE widgets SET
	     position = position + 1
	    WHERE page_id = #{self.page.id}
	      AND position >= #{self.position}
	      AND id <> #{self.id}
SQL
	  )
	end
	
	def increment_position_between(position1, position2)
	  # Incremement placements on this page between 2 positions
	  ActiveRecord::Base.connection.execute(<<SQL
	    UPDATE widgets SET
	     position = position + 1
	    WHERE page_id = #{self.page.id}
	      AND position >= #{position1}
				AND position < #{position2}
	      AND id <> #{self.id}
SQL
	  )
	end
	
  def decrement_after
    # Decrement all later placements on this page.
    ActiveRecord::Base.connection.execute(<<SQL
    UPDATE widgets SET
      position = position - 1
    WHERE page_id = #{self.page.id}
      AND position >= #{self.position}
      AND id <> #{self.id}
SQL
      )
  end

	def decrement_position_between(position1, position2)
		# decrements placements on a page between 2 positions
	  ActiveRecord::Base.connection.execute(<<SQL
	  UPDATE widgets SET
	    position = position - 1
	  WHERE page_id = #{self.page.id}
	    AND position <= #{position1}
			AND position > #{position2}
	    AND id <> #{self.id}
SQL
	    )
	end

end
