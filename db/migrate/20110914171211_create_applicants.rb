class CreateApplicants < ActiveRecord::Migration
  def self.up
    create_table :canvas_applicants do |t|
      t.integer :canvas_id
      t.integer :user_id
      t.string :note

      t.timestamps
    end
  end

  def self.down
    drop_table :canvas_applicants
  end
end
