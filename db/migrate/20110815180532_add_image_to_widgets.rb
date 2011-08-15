class AddImageToWidgets < ActiveRecord::Migration
  def self.up
    add_column :widgets, :image, :string
  end

  def self.down
    remove_column :widgets, :image
  end
end
