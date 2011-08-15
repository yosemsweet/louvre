class RenameContentToTextOnWidgets < ActiveRecord::Migration
  def self.up
		rename_column :widgets, :content, :text
  end

  def self.down
		rename_column :widgets, :text, :content
  end
end
