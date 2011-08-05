class UsersController < ApplicationController
  def hud
    @number_of_follow_canvae = current_user.followed_canvae.length
    render :layout => false
  end
end
