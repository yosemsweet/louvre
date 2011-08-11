class TagsController < ApplicationController

  def index
    @tags = Tag.where("name like ?", "%#{params[:q]}%").limit(20)
    render :json => @tags.map(&:attributes)
  end
  
end
