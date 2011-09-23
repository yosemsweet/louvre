class AddEditorToWidgets < ActiveRecord::Migration
  def self.up
    add_column :widgets, :editor_id, :integer
  end

  def self.down
    remove_column :widgets, :editor_id
  end
end
