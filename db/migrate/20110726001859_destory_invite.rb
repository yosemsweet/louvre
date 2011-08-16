class DestoryInvite < ActiveRecord::Migration
  def self.up
    drop_table :invites
  end

  def self.down
    create_table :invites do |t|
      t.integer :inviter_id
      t.string :invitee_email
      t.integer :canvas_id

      t.timestamps
    end
  end
end
