class TagsController < ApplicationController

  def index
    @tags = Tag.where("name like ?", "%#{params[:q]}%")
    render :json => @tags.map(&:attributes)
  end
  
end
