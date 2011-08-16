class Widget < ActiveRecord::Base
  
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  
  attr_writer :tag_ids
  after_save :assign_tags
  
  
  belongs_to :page
  belongs_to :canvas
	belongs_to :creator, :class_name => "User"
	belongs_to :parent, :class_name => "Widget"
	
  has_paper_trail :meta => { :page_id => Proc.new{ |widget| widget.page ? widget.page.id : nil }}
  acts_as_opengraph :values => { :type => "cause" }
	acts_as_followable
    
  validates_presence_of :canvas, :creator, :content_type
  validates_presence_of :alt_text, :image,  :if => :image?

  def tag_ids
    @tag_ids || tags.map(&:id).join(',')
  end
  
  def self.filter_by_tag_ids(tag_ids)
    Widget.joins(:taggings) & Tagging.where(:tag_id => tag_ids)
  end

  def self.site_feed
    widgets = []
		10.times do
			widgets << Widget.random
		end
		return widgets
  end
  
  def self.for_canvas(canvas_id, start)
    canvae = Canvas.find(canvas_id).widgets.where(:page_id => nil)
    if start
      canvae = canvae.where("id >= #{start}")
    end
    return canvae
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
	
	def assign_tags
	  if @tag_ids
	    self.tags = @tag_ids.split(',').map do |tag_id|
	      Tag.find(tag_id)
      end
    end
  end
	
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
