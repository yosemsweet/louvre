class Page < ActiveRecord::Base

	belongs_to :canvas
	belongs_to :creator, :class_name => "User"
	has_many :widgets
		
	validates_presence_of :title
	validates_presence_of :creator
	validates_presence_of :canvas
	
	def revisions_list
	  page_versions = []
	  self.widgets.each do |w|
	    w.versions.each do |v|
	     page_versions << v
      end
    end
    
    page_versions = page_versions.sort {|pv| pv.created_at.to_date}
    
    revisions = ""
    
    page_versions.each do |pv|
      revisions << "#{pv.reify.content}|"
    end
    
    revisions
        
  end
	
end
