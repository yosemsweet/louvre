class UsersController < ApplicationController
  before_filter :require_login, :only => [:edit, :hud]
  
  def hud
    render :layout => false
  end
  
  def edit
    @email = Email.new(:user => current_user)
  end
  
end
