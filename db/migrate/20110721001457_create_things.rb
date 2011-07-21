class CreateThings < ActiveRecord::Migration
  def self.up
    create_table :things do |t|
      t.integer :canvas_id
      t.text :content
      t.integer :creator_id

      t.timestamps
    end
  end

  def self.down
    drop_table :things
  end
end
