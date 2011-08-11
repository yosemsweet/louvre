class Tagging < ActiveRecord::Base
  belongs_to :widget
  belongs_to :tag
end
