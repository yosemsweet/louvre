class AddQuestionAnswerToWidget < ActiveRecord::Migration
  def self.up
	  add_column :widgets, :question, :text
	  add_column :widgets, :answer, :text
  end

  def self.down
		remove_column :widgets, :question
		remove_column :widgets, :answer
  end
end
