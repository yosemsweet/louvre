class DiscussionsController < ApplicationController
  
  
  def show
    @canvas = Canvas.find(params[:canvas_id])
    render :layout => false
  end
  
end
