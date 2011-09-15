class CanvaeController < ApplicationController	
	before_filter :require_login, :except => [:show, :index]
  before_filter :only => [:show, :edit] do
    @canvas = Canvas.find(params[:id])
    @title = @canvas.name
  end

  def edit
		authorize! :edit, @canvas
		add_breadcrumb "Edit '#{@canvas.name}'", edit_canvas_path(@canvas)
  end  
    
  def show
    # Create a blank widget for each widget type.
    @new_widgets = {
      :text_widget => Widget.new(:content_type => "text_content", :canvas => @canvas),
      :image_widget => Widget.new(:content_type => "image_content", :canvas => @canvas),
      :link_widget => Widget.new(:content_type => "link_content", :canvas => @canvas),
      :question_widget => Widget.new(:content_type => "question_content", :canvas => @canvas)
    }
    
		add_canvas_breadcrumb(@canvas)
  end
    
  def index
    @canvae = Canvas.all
  end

  def new
    canvas_name = params[:canvas_name] || ""
    @canvas = Canvas.new(:name => canvas_name)

		add_breadcrumb "Add Canvas", new_canvas_path()
  end

  def create
    @canvas = Canvas.new(params[:canvas])

		@canvas.creator = current_user

    if @canvas.save
      redirect_to(@canvas, :notice => 'Canvas created!')
    else
      render :action => "new" 
    end
  end

  def update
    @canvas = Canvas.find(params[:id])
		authorize! :update, @canvas

    if @canvas.update_attributes(params[:canvas])
      redirect_to(@canvas, :notice => 'Canvas was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @canvas = Canvas.find(params[:id])
		authorize! :delete, @canvas
		
    @canvas.destroy
    redirect_to(root_url)
  end

 	def members
		@canvas = Canvas.find(params[:id])
		authorize! :update, @canvas
  end

 	def banned
		@canvas = Canvas.find(params[:id])
		authorize! :update, @canvas
  end
  
  def applicants
    @canvas = Canvas.find(params[:id])
		authorize! :manage, CanvasApplicant.new(:canvas_id => @canvas.id)

    @canvas_applicants = @canvas.canvas_applicants
    @applicants = @canvas.applicants
  end
  
  def members_create
    @canvas = Canvas.find(params[:id])
    authorize! :update, @canvas
    @user = User.find(params[:user_id])
    @canvas.canvas_applicants.where(:user_id => @user.id).delete_all
    @user.set_canvas_role(@canvas, :member)
    head :ok
  end

 	def banned_create		
		@canvas = Canvas.find(params[:id])
		authorize! :update, @canvas
	 	begin
			user = User.find(params[:user_id])
			if current_user.canvas_role(@canvas) > user.canvas_role(@canvas)
				user.set_canvas_role(@canvas, :banned)
				user.save!
				head :ok
			else
				head :forbidden
			end
		rescue
			head :bad_request
		end
  end

	def banned_destroy
		@canvas = Canvas.find(params[:id])
		authorize! :update, @canvas
		begin
			user = User.find(params[:user_id])
			if current_user.canvas_role(@canvas) > user.canvas_role(@canvas)
				@canvas.banned.where(:user_id => user.id).destroy_all
				user.save!
				head :ok
			else
				head :forbidden
			end
		rescue
			head :bad_request
		end
	end

  def applicants_delete
    @canvas = Canvas.find(params[:id])
    authorize! :update, @canvas
    @user = User.find(params[:user_id])
    @canvas.canvas_applicants.where(:user_id => @user.id).delete_all
    head :ok
  end

end
