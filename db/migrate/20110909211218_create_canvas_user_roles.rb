class CreateCanvasUserRoles < ActiveRecord::Migration
  def self.up
    create_table :canvas_user_roles do |t|
      t.integer :canvas_id
      t.integer :user_id
      t.integer :role_id

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
