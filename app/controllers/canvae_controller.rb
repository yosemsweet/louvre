class CanvaeController < ApplicationController
	
	before_filter :require_login, :except => [:show, :index]
  before_filter :only => [:show, :edit] do
    @canvas = Canvas.find(params[:id])
    @title = @canvas.name
  end

  def edit
		add_breadcrumb "Edit '#{@canvas.name}'", edit_canvas_path(@canvas)
  end  
    
  def show
    # Create a blank widget for each widget type.
    @new_widgets = {
      :text_widget => Widget.new(:content_type => "text_content", :canvas => @canvas),
      :image_widget => Widget.new(:content_type => "image_content", :canvas => @canvas),
      :link_widget => Widget.new(:content_type => "link_content", :canvas => @canvas)
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

    if @canvas.update_attributes(params[:canvas])
      redirect_to(@canvas, :notice => 'Canvas was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @canvas = Canvas.find(params[:id])
    @canvas.destroy
    redirect_to(canvae_url)
  end
end
