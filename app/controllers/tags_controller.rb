class TagsController < ApplicationController

  def index
    render :json => Tag.all.map(&:attributes)
  end
  
end
