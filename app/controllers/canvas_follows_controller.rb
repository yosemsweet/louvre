class CanvasFollowsController < ApplicationController

  def create
    puts current_user.name    
    @canvas_follow = CanvasFollow.new(params[:canvas_follow])
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
