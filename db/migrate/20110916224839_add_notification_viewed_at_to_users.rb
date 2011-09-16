class AddNotificationViewedAtToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :notifications_viewed_at, :datetime
  end

  def self.down
    remove_column :users, :notifications_viewed_at
  end
end
