class EmailsController < ApplicationController
  
  def index
    @emails = current_user.emails
    render :layout => false
  end
  
  def create
    Email.create(:user => current_user, :address => params['email']['address'])
    head :ok
  end
  
  def destroy
    Email.find(params[:id]).delete
    head :ok
  end
  
end
