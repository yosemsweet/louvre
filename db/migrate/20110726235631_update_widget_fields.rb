class UpdateWidgetFields < ActiveRecord::Migration
  def self.up
		remove_column :widgets, :name
		remove_column :widgets, :change_comment
		add_column :widgets, :parent_id, :integer
  end

  def self.down
		add_column :widgets, :name, :string
		add_column :widgets, :change_comment, :text
		remove_column :widgets, :parent_id
  end
end
