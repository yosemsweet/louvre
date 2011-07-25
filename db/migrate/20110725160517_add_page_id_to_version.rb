class AddPageIdToVersion < ActiveRecord::Migration
  def self.up
    
    add_column :versions, :page_id, :integer  
  
  end

  def self.down

    remove_column :versions, :page_id, :integer

  end
end
