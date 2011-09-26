class AddEditorIdToCanvas < ActiveRecord::Migration
  def self.up
    add_column :canvae, :editor_id, :integer
  end

  def self.down
    remove_column :canvae, :editor_id
  end
end
