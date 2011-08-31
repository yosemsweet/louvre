class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string :address
      t.integer :primary
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
