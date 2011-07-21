class TextContent < ActiveRecord::Base

  has_one :widget, :as => :content

end
