class AmalgamateWidgetContentIntoWidgets < ActiveRecord::Migration
  def self.up
    
    remove_column :widgets, :content_id
    add_column :widgets, :content, :text
    add_column :widgets, :change_comment, :text
        
  end

  def self.down
    
    remove_column :widgets, :change_comment
    remove_column :widgets, :content    
    add_column :widgets, :content_id, :integer
    
  end
end
