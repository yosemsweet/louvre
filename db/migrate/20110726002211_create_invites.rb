class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.integer :inviter_id
      t.string :invitee_email
      t.integer :canvas_id

      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end
end
