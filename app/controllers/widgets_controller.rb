class WidgetsController < ApplicationController
  
	before_filter :load_canvas, :except => :destroy
  
  def index
    @widgets = Widget.all
  end

  def show
    @widget = Widget.find(params[:id])
  end

  def new
    @widget = Widget.new(:content_type => params[:content_type])
		
    @widget.page = Page.find(params[:page_id]) if params[:page_id]
    @widget.content_type = params[:content_type] || 'text_content'
    
    render :layout => "edit_widget"
  end

  def edit
    @widget = Widget.find(params[:id])
    
    render :layout => "edit_widget"
  end

  def create    
    
    @widget = @canvas.widgets.new(params[:widget])
    @widget.creator ||= current_user

		respond_to do |format|  
    	if @widget.save
				format.html { render 'update_page', :layout => false }
     		format.json { render :json => @widget, :status => :created }
	    else
	      head :bad_request
	    end
		end

  end

  def update
    @widget = Widget.find(params[:id])

    if @widget.update_attributes(params[:widget])
      render 'update_page', :layout => false
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
