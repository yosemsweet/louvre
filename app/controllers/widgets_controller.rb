class WidgetsController < ApplicationController 
  before_filter :require_login, :only => [:new, :edit, :update, :move, :copy_to_page, :destroy]

  # GET /widgets
  def index 
    @widgets = Widget.site_feed
    render :partial => "scrolly", :collection => @widgets, :as => :widget
  end
  
  # GET /widgets/for_canvas/:canvas_id/:display
  def for_canvas
    @widgets = Widget.for_canvas(params[:canvas_id], params[:start])
    render :partial => params[:display], :collection => @widgets, :as => :widget
  end
  
  # GET /widgets/for_page/:canvas_id/:display  
  def for_page
    @widgets = Widget.for_page(params[:page_id])
    render :partial => params[:display], :collection => @widgets, :as => :widget
  end

  # GET /widgets/:id
  def show
    # render :json => Widget.find(params[:id])
		@widget = Widget.find(params[:id])
  end

  # GET /widgets/:id/new
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

  # GET /widgets/:id/edit
  def edit
    @widget = Widget.find(params[:id])
    
    render :layout => 'empty'
  end

  # POST /widgets
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

    if @widget.save
      if request.xhr?
        head :created
      else
        render :inline => "<script type='text/javascript'>window.top.update_after_edit();</script>"
      end
    else
      head :bad_request
    end
  end
  
  # POST /widgets/:id/copy_to_page/:page_id
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

  # PUT /widgets/:id
  def update
    @widget = Widget.find(params[:id])

    if @widget.update_attributes(params[:widget])
      render :inline => "<script type='text/javascript'>window.top.update_after_edit();</script>"
    else
      head :bad_request
    end    
      
  end
  
  # PUT /widgets/:id/:position
  def move
		widget = Widget.find(params[:id])
		
		if widget.update_position(params[:position])
			head :ok
		else
			head :bad_request
		end	
	end

  # DELETE /widgets/:id
  def destroy
    widget = Widget.find(params[:id])
    widget.remove_page_position
    widget.destroy
    head :ok
  end
  
end
