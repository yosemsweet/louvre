class RemoveCommentsAndCanvasFollows < ActiveRecord::Migration
  def self.up
    drop_table :comments
    drop_table :canvas_follows
  end

  def self.down
    create_table :comments do |t|
      t.integer :creator_id
      t.text :content
      t.integer :widget_id
      t.timestamps
    end
    create_table :canvas_follows do |t|
      t.integer :user_id
      t.integer :canvas_id
      t.timestamps
    end
  end
end
