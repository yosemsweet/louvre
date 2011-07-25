class CreateWidgets < ActiveRecord::Migration
  def self.up
    create_table :widgets do |t|
      t.string :name
      t.integer :position
      t.integer :page_id
      t.integer :canvas_id
      t.integer :creator_id
      t.integer :content_id
      t.string :content_type

      t.timestamps
    end
  end

  def self.down
    drop_table :widgets
  end
end
