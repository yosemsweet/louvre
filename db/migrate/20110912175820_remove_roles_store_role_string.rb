class RemoveRolesStoreRoleString < ActiveRecord::Migration
  def self.up
    drop_table :roles
    remove_column :canvas_user_roles, :role_id
    add_column :canvas_user_roles, :role, :string
  end

  def self.down
    remove_column :canvas_user_roles, :role
    add_column :canvas_user_roles, :role_id, :integer
    create_table :roles do |t|
      t.string :name
      t.integer :xp

      t.timestamps
    end
  end
end
