class AddCanvasToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :canvas_id, :integer
  end

  def self.down
    remove_column :pages, :canvas_id
  end
end
