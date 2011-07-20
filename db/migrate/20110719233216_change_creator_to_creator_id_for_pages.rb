class ChangeCreatorToCreatorIdForPages < ActiveRecord::Migration
	
  def self.up
    remove_column :pages, :creator
	  add_column :pages, :creator_id, :integer
  end

  def self.down
    remove_column :pages, :creator_id, :integer
	  add_column :pages, :creator, :integer
  end

end
