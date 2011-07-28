class WidgetsController < ApplicationController

  def update_position
		widget = Widget.find(params[:id])
		
		if widget.update_position(params[:position])
			head :ok
		else
			head :bad_request
		end	
	end
	
	def clone_widget
		
		widget = Widget.find(params[:id])
		
		cloned_widget = widget.widget_clone
		cloned_widget.page_id = params[:page_id]
		
		if cloned_widget.save && cloned_widget.insert_position(params[:position])
			render :json => cloned_widget.id
		else
			head :bad_request
		end
		
	end

  def index
    @widgets = Canvas.find(params[:canvas_id]).input_stream_widgets
    render :layout => false
  end

  def show
    @widget = Widget.find(params[:id])
  end

  def new
    @widget = @canvas.widgets.new(:content_type => params[:content_type])
		
    @widget.page = Page.find(params[:page_id]) if params[:page_id]
    @widget.content_type = params[:content_type] || 'text_content'
    
    render :layout => false
  end

  def edit
    @widget = Widget.find(params[:id])
    
    render :layout => false
  end

  def create    
    canvas = Canvas.find(params[:canvas_id])
    widget_params = params[:widget]
    
    @widget = canvas.widgets.new(widget_params)
    if !widget_params[:creator_id]
      @widget.creator = current_user
    end
    
    if widget_params[:page_id]
		  @widget.position_last_on_page
	  end

		respond_to do |format|  
    	if @widget.save
				format.html { redirect_to(canvas_path(@widget.canvas), :notice => 'widget was successfully created.') }
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

  def destroy
    widget = Widget.find(params[:id])
    widget.remove_page_position
    widget.destroy
    head :ok
  end
  
end
