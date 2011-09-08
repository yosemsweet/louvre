class TagsController < ApplicationController

  def index
    # render :json => Tag.search(params[:q])
    render :json => Tag.search(params[:search])
  end
  
end
