class UsersController < ApplicationController
  before_filter :require_login
  
	def index
		puts current_user
		@users = User.all
		authorize! :make_admin, User
	end

  def hud
    render :layout => false
  end
  
  def edit
    @email = Email.new(:user => current_user)
  end
  
end
