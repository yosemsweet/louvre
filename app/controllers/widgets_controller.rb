class WidgetsController < ApplicationController
  layout false

  def index 
    @widgets = Widget.site_feed
    render :partial => "scrolly", :collection => @widgets, :as => :widget
  end
  
  def for_canvas
    @widgets = Widget.for_canvas(params[:canvas_id], params[:start])
    render :partial => params[:display], :collection => @widgets, :as => :widget
  end
  
  def for_page
    @widgets = Widget.for_page(params[:page_id])
    render :partial => params[:display], :collection => @widgets, :as => :widget
  end

	def copy_to_page
		widget = Widget.find(params[:id])
		
		cloned_widget = widget.clone
		cloned_widget.page_id = params[:page_id]

		if cloned_widget.save && cloned_widget.insert_position(params[:position])
			render :json => cloned_widget.id
		else
			head :bad_request
		end
	end
	
	def move
		widget = Widget.find(params[:id])
		
		if widget.update_position(params[:position])
			head :ok
		else
			head :bad_request
		end	
	end

  def show
    @widget = Widget.find(params[:id])
  end

  def new
    
    if params[:page_id]
      page = Page.find(params[:page_id])
      canvas = page.canvas  
    else
      page = nil
      canvas = Canvas.find(params[:canvas_id])
    end
    
    @widget = canvas.widgets.new(:content_type => params[:content_type], :page => page)
    
    render :layout => 'empty'
  end

  def edit
    @widget = Widget.find(params[:id])
    
    render :layout => 'empty'
  end

  def create      
    if params[:page_id]
      page = Page.find(params[:page_id])
      canvas = page.canvas
    else
      page = nil
      canvas = Canvas.find(params[:canvas_id])
    end
    
    @widget = canvas.widgets.new(params[:widget].merge(:page => page, :canvas => canvas))
    
    if page
		  @widget.position_last_on_page
	  end

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

  def destroy
    widget = Widget.find(params[:id])
    widget.remove_page_position
    widget.destroy
    head :ok
  end
  
end
