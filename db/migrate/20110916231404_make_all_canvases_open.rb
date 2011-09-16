class MakeAllCanvasesOpen < ActiveRecord::Migration
  def self.up
    Canvas.all.each do |c|
      c.update_attributes(:open => true)
    end
  end

  def self.down
  end
end
