class Widget < ActiveRecord::Base
  
  belongs_to :page
  belongs_to :canvas
	belongs_to :creator, :class_name => "User"

  has_paper_trail :meta => { :page_id => Proc.new{ |widget| widget.page.id }}
    
  validates_presence_of :canvas
  validates_presence_of :creator
	
	# validates :position, :numericality => { :only_integer => true }

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
	
	def initialize_position
		if !self.page
			self.position = nil
		else
			self.position = self.page.widgets.length + 1
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
	
end
