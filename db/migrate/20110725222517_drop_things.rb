class DropThings < ActiveRecord::Migration
  def self.up
		drop_table :things
  end

  def self.down
	  create_table :things do |t|
      t.integer :canvas_id
      t.text :content
      t.integer :creator_id

      t.timestamps
    end
  end
end
