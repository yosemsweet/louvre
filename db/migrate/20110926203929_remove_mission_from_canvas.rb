class RemoveMissionFromCanvas < ActiveRecord::Migration
  def self.up
    remove_column :canvas, :mission
  end

  def self.down
    add_column :canvas, :mission, :text
  end
end
