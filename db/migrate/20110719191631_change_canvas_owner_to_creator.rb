class ChangeCanvasOwnerToCreator < ActiveRecord::Migration
  def self.up
    remove_column :canvae, :owner_id
    add_column :canvae, :creator_id, :integer
  end

  def self.down
    remove_column :canvae, :creator_id
    add_column :canvae, :owner_id, :integer
  end
end
