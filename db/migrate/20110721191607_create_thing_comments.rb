class CreateThingComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :content
      t.integer :creator_id
      t.integer :thing_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
