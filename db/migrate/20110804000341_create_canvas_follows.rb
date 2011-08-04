class CreateCanvasFollows < ActiveRecord::Migration
  def self.up
    create_table :canvas_follows do |t|
      t.integer :user_id
      t.integer :canvas_id

      t.timestamps
    end
  end

  def self.down
    drop_table :canvas_follows
  end
end
