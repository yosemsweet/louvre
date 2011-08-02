class CanvaeController < ApplicationController

  before_filter :only => [:show, :edit] do
    @canvas = Canvas.find(params[:id])
    @title = @canvas.name
  end

  def edit
  end  
    
  def show
  end
    
  def index
    @canvae = Canvas.all
  end

  def new
    canvas_name = params[:canvas_name] || ""
    @canvas = Canvas.new(:name => canvas_name)
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
