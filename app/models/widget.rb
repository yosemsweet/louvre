class Widget < ActiveRecord::Base
  
  belongs_to :content, :polymorphic => true
  belongs_to :page
  belongs_to :canvas
  
  validates_presence_of :canvas
  
  def build_empty_content(type = "TextContent")
    begin
      self.content = type.constantize.new
    rescue
      self.content = TextContent.new
    end
  end
  
end
