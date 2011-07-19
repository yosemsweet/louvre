class CreateCanvae < ActiveRecord::Migration
  def self.up
    create_table :canvae do |t|
      t.string :name
      t.text :mission
      t.string :image_url
      t.integer :owner_id

      t.timestamps
    end
  end

  def self.down
    drop_table :canvae
  end
end
