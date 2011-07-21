class WidgetsController < ApplicationController
  
	before_filter :load_canvas, :except => :destroy
  
  def index
    @widgets = Widget.all
  end

  def show
    @widget = Widget.find(params[:id])
  end

  def new
    @widget = Widget.new
    @widget.build_empty_content(params[:content_type])
  end

  def edit
    @widget = Widget.find(params[:id])
  end

  def create
        
    @widget = @canvas.widgets.new(params[:widget])
    @widget.build_empty_content(params[:content_type])
    
    if @widget.save && @widget.content.update_attributes(params[:content])
      render :layout => false
    else
      head :bad_request
    end

  end

  def update
    @widget = Widget.find(params[:id])

    # TODO: Wrap these updates in a transaction
    if @widget.content.update_attributes(params[:content]) && @widget.update_attributes(params[:widget])
      head :ok
    else
      head :bad_request
    end    
      
  end

  # TODO: fix this method for nested resource
  def destroy
    @widget = Widget.find(params[:id])
    @widget.destroy
    head :ok
  end
  
  private 
	
	def load_canvas
		@canvas = Canvas.find(params[:canvas_id])
	end
  
end
