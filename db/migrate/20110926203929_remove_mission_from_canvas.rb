class RemoveMissionFromCanvas < ActiveRecord::Migration
  def self.up
    remove_column :canvae, :mission
  end

  def self.down
    add_column :canvae, :mission, :text
  end
end
