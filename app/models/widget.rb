class Widget < ActiveRecord::Base
  
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  
  attr_writer :tag_names
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
	validates_presence_of :link, :title,  :if => :link?


  # Get an array of the facebook comment messages for this widget.
  def comments
    graph = Koala::Facebook::GraphAPI.new

    if fb_comments = graph.get_comments_for_urls([permalink])
      return fb_comments[permalink]["data"].map {|c| {:message => c["message"], :comment_date => c["created_time"], :commenter => c["from"]["name"]} }
    else
      return []
    end
  end

  def answers
    if answer
      ActiveSupport::JSON.decode(answer)
    else
      nil
    end
  end

  def permalink
    if Rails.env == :production
      "http://www.loorp.com/widgets/#{self.id}"
    else
      "http://localhost:3000/widgets/#{self.id}"
    end
  end

  def tag_ids
    @tag_ids || tags.map(&:id).join(',')
  end
  
  def tag_names
    @tag_names || tags.map(&:name).join(',')
  end
  
  def self.filter_by_tag_names(tag_names)
    if tag_names.empty?
      # Return all tags.
      scoped
    else
      # Get all the tags matching this name.
      (Widget.joins(:tags) & Tag.where(:name => tag_names)).group("widgets.id, widgets.position, widgets.page_id, widgets.canvas_id,
					widgets.creator_id, widgets.content_type, widgets.created_at, widgets.updated_at, widgets.text, widgets.parent_id, widgets.alt_text,
					widgets.image, widgets.link, widgets.title, widgets.question, widgets.answer")
    end
  end

  def self.site_feed
    widgets = []
		10.times do
			widgets << Widget.random
		end
		return widgets
  end
  
  def self.for_canvas(canvas_id, start)
    canvae = Canvas.find(canvas_id).widgets.where(:page_id => nil).order("created_at DESC").limit(15)
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

	def link?
		content_type == 'link_content'
	end
	
	def text?
		content_type == 'text_content'
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
	  if @tag_names
	    self.tags = []
	    @tag_names.split(',').each do |tag_name|
	      self.tags << (Tag.where(:name => tag_name).first || Tag.create(:name => tag_name))
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
