class Widget < ActiveRecord::Base
  
  belongs_to :page
  belongs_to :canvas
	belongs_to :creator, :class_name => "User"
	
	has_many :comments

	accepts_nested_attributes_for :comments

  has_paper_trail :meta => { :page_id => Proc.new{ |widget| widget.page ? widget.page.id : nil }}
    
  validates_presence_of :canvas, :creator, :content_type
  validates_presence_of :alt_text, :if => :image?

  def image?
    content_type == 'image_content'
  end
    
	def update_position(new_position)
		
		old_position = self.position
		position_change = new_position.to_i - old_position
		
		if self.update_attributes({:position => new_position})
			
			if position_change > 0
				decrement_before
			elsif position_change < 0
				increment_after
			end
			
			return true
			
		else
			return false
		end
		
	end
	
	def initialize_page_position
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

end
