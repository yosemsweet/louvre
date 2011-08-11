class TagsController < ApplicationController

  def index
    render :json => Tag.search(params[:q])
  end
  
end
