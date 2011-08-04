class CanvasFollowsController < ApplicationController

  before_filter do
    if !current_user
      head :bad_request
    else
      @canvas_follow_params = {:canvas_id => params[:canvas_id], :user_id => current_user.id}
    end
  end

  def create
    if CanvasFollow.exists?(@canvas_follow_params)    
      head :ok
    else
      if CanvasFollow.new(@canvas_follow_params).save
        head :ok
      else
        head :bad_request
      end
    end
  end

  def destroy
    CanvasFollow.where(@canvas_follow_params).destroy_all    
    head :ok
  end
end
