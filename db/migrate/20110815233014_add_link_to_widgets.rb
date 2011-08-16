class AddLinkToWidgets < ActiveRecord::Migration
  def self.up
    add_column :widgets, :link, :string
    add_column :widgets, :title, :string
  end

  def self.down
    remove_column :widgets, :link
    remove_column :widgets, :title
  end
end
