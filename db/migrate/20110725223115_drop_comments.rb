class DropComments < ActiveRecord::Migration
  def self.up
		drop_table :comments
  end

  def self.down
	  create_table :comments do |t|
      t.text :content
      t.integer :creator_id
      t.integer :thing_id

      t.timestamps
    end
  end
end
