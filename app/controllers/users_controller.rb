class UsersController < ApplicationController
  before_filter :require_login
  
	def index
		@users = User.all
		authorize! :make_admin, User
	end
  
  def edit
    @email = Email.new(:user => current_user)
  end

	def update
		@user = User.find(params[:id])
	  authorize! :make_admin, User
		
    if @user.update_attributes(params[:user])
      head :ok
    else
      head :bad_request
    end
	end
  
end
