class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :interested_in

      t.timestamps
    end
  end

  def self.down
    drop_table :feedbacks
  end
end
