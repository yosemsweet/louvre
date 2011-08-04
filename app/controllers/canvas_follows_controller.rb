class CanvasFollowsController < ApplicationController

  def create    
    @canvas_follow = CanvasFollow.new(:canvas_id => params[:canvas_id], :user_id => current_user.id)
    if @canvas_follow.save
      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    @canvas_follow = CanvasFollow.find(params[:id])
    @canvas_follow.destroy    
    head :ok
  end
end
