class WidgetsController < ApplicationController 
  before_filter :require_login, :only => [:new, :edit, :update, :move, :copy_to_page, :destroy]

  # GET /widgets
  def index 
    @widgets = Widget.site_feed.first(10)
    render :partial => "scrolly", :collection => @widgets, :as => :widget
  end
  
  # GET /widgets/for_canvas/:canvas_id/:display
  def for_canvas
    
    @widgets = Widget.for_canvas(params[:canvas_id], params[:start])
    
    if params[:tag_ids] && !params[:tag_ids].blank?
      @widgets = @widgets.filter_by_tag_ids(params[:tag_ids].split(','))
    end

    render :partial => params[:display], :collection => @widgets, :as => :widget
  end
  
  # GET /widgets/for_page/:canvas_id/:display  
  def for_page
    @widgets = Widget.for_page(params[:page_id])
    render :partial => params[:display], :collection => @widgets, :as => :widget
  end

  # GET /widgets/:id
  def show
		@widget = Widget.find(params[:id])
		
		add_canvas_breadcrumb(@widget.canvas)
		add_page_breadcrumb(@widget.page) if @widget.page
		add_breadcrumb @widget.content.truncate(30), widget_path(@widget)
  end

  # GET /widgets/:id/new
  def new
    if params[:page_id]
      @page = Page.find(params[:page_id])
      @canvas = @page.canvas  
    else
      @page = nil
      @canvas = Canvas.find(params[:canvas_id])
    end
    
    @widget = @canvas.widgets.new(:content_type => params[:content_type], :page => @page) 
    
    render :layout => 'empty'
  end

  # GET /widgets/:id/edit
  def edit
    @widget = Widget.find(params[:id])
    @page = @widget.page
    @canvas = @widget.canvas
    
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
      head :created
    else
      head :bad_request
    end  
    
  end
  
  # POST /widgets/:id/copy_to_page/:page_id
  def copy_to_page
		widget = Widget.find(params[:id])
		
		cloned_widget = widget.clone
		cloned_widget.page_id = params[:page_id]
		
		# Copy comments for question widgets.
	  if widget.content_type == 'question_content'
	    graph = Koala::Facebook::GraphAPI.new
	    widget_url = "http://localhost:3000/widgets/#{widget.id}"
	    fb_comments = graph.get_comments_for_urls([widget_url])
	    comments = fb_comments[widget_url]["data"].map {|c| c["message"]}
      cloned_widget.answer = comments.join(";")
    end

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
      head :ok
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

  def create_via_email

    # extract email address out of the from field
    email = params['from'].match("([a-z,A-Z,0-9,.,!,#,$,%,&,',*,+,-,\/,=,?,^,_,`,{,|,},~]*)@[a-z,A-Z,0-9,.,-]*")[0]
    
    canvas_id = params['to'].split('@').first
    user = User.find_by_email(email)
    
    if user
      
      widget = Widget.new(:canvas_id => canvas_id, :creator_id => user.id, :content_type => 'text_content', :text => params['text'])

      if widget.save
        @mixpanel.track_event("Widget Created via Email", {:user_id => user.id, :name_tag => user.name, :canvas_id => canvas_id})
        head :created
      else
        head :bad_request
      end
    else
      head :bad_request
    end
    
  end

end
