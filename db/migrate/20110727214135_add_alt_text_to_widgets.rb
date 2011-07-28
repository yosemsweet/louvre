class AddAltTextToWidgets < ActiveRecord::Migration
  def self.up
    add_column :widgets, :alt_text, :string
  end

  def self.down
    remove_column :widgets, :alt_text
  end
end
