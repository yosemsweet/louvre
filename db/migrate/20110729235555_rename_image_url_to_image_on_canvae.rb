class RenameImageUrlToImageOnCanvae < ActiveRecord::Migration
  def self.up
		rename_column :canvae, :image_url, :image
  end

  def self.down
		rename_column :canvae, :image, :image_url
  end
end
