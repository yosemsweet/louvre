class AddOpenToCanvas < ActiveRecord::Migration
  def self.up
		add_column :canvae, :open, :boolean, :default => true
  end

  def self.down
		remove_column :canvae, :open
  end
end
