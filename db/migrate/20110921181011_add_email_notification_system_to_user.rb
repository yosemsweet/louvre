class AddEmailNotificationSystemToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :can_email, :boolean
    add_column :users, :last_action, :datetime
  end

  def self.down
    remove_column :users, :last_action
    remove_column :users, :can_email
  end
end
