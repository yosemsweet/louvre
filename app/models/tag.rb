class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :widgets, :through => :taggings

  def self.search(query)
    # select("id, name").where("name like ?", "%#{query}%").limit(20).map(&:attributes)
    select("id, name").where("name like ?", "%#{query}%").limit(20).map{|o| [o.id, o.name.strip]}
  end
  
end
