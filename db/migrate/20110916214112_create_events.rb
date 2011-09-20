class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :canvas_id
      t.integer :loggable_id
      t.string :loggable_type
      t.integer :user_id
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
