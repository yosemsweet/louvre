class WidgetsController < ApplicationController 
  before_filter :require_login, :only => [:new, :edit, :update, :move, :copy_to_page, :destroy]
	
  before_filter :only => [:edit_history, :show, :widget_tags, :edit, :update, :feed_widget] do
    @widget = Widget.find(params[:id])
		@canvas = @widget.canvas
  end

  # GET /widgets
  def index 
    @widgets = Widget.site_feed.first(10)
    render :partial => "scrolly", :collection => @widgets, :as => :widget
  end
  
  # GET /widgets/for_canvas/:canvas_id/:display
  def for_canvas
    @widgets = Widget.for_canvas(params[:canvas_id], params[:start])
    
    if params[:tag_names].present?
      @widgets = @widgets.filter_by_tag_names(params[:tag_names].split(','))
    end

    render :partial => params[:display], :collection => @widgets, :as => :widget
  end
  
	def edit_history
    render :partial => "edit_history"
	end

  # GET /widgets/for_page/:canvas_id/:display  
  def for_page
    @widgets = Widget.for_page(params[:page_id])
    render :partial => params[:display], :collection => @widgets, :as => :widget
  end

  # GET /widgets/:id
  def show
    authorize! :read, @widget

		respond_to do |format|
      format.html {
	
			}
      format.json{
        render :json => @widget.to_json
      }
    end
		
  end

  # GET /widgets/:id
  def widget_tags
    authorize! :read, @widget

		@tags = @widget.tags
		
		respond_to do |format|
      format.html{

      }
      format.json{
        render :json => @tags.to_json
      }
    end
		
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

	  authorize! :create, @widget

    @widget = @canvas.widgets.new(:content_type => params[:content_type], :page => @page)

    render :layout => 'empty'
  end

  # GET /widgets/:id/edit
  def edit
    @page = @widget.page
    @canvas = @widget.canvas

	  authorize! :update, @widget
    
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

    if params[:widget][:creator_id].present?
      @widget = canvas.widgets.new(params[:widget].merge(:page => page, :canvas => canvas, :editor_id => params[:widget][:creator_id]))			
			user = User.find(params[:widget][:creator_id])
			method = "bookmarklet"
    else    
      @widget = canvas.widgets.new(params[:widget].merge(:page => page, :canvas => canvas, :creator => current_user, :editor => current_user))
      authorize! :create, @widget
    end

		user ||= current_user
		method ||= "site"
		@mixpanel.track_event("widget_added", {
					:user_id => user.id, 
					:distinct_id => user.id, 
					:mp_name_tag => user.name, 
					:canvas_id => canvas.id, 
					:method => method,
					:ip => request.remote_ip})
		
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
		
		authorize! :update, widget
		
		cloned_widget = widget.clone
		cloned_widget.editor = current_user
		cloned_widget.page_id = params[:page_id]
		
		# Copy comments for question widgets.
	  if widget.content_type == 'question_content'
      cloned_widget.answer = widget.comments.to_json
    end

		if cloned_widget.save && cloned_widget.insert_position(params[:position])
			render :json => cloned_widget.id
		else
			head :bad_request
		end
	end

  # PUT /widgets/:id
  def update
		# logger.debug 'message0'
	  authorize! :update, @widget

    if @widget.update_attributes(params[:widget].merge(:editor_id => current_user.id))
      head :ok
    else
      head :bad_request
    end   
  
  end
  
  # PUT /widgets/:id/move/:position
  def move
		widget = Widget.find(params[:id])
		
		authorize! :update, widget

		p = widget.page	
		p.editor_id = current_user.id
		p.save!
		
		if widget.update_position(params[:position])
			head :ok
		else
			head :bad_request
		end	
	end

  # PUT /widgets/:id/remove_answer/:answer_id
  def remove_answer
    widget = Widget.find(params[:id])

		authorize! :update, widget
		
    new_answers = widget.answers
    new_answers.delete_at(params[:answer_id].to_i) 
    widget.update_attributes(:answer => new_answers.to_json, :editor => current_user)
    
    head :ok
  end

  # DELETE /widgets/:id
  def destroy
    widget = Widget.find(params[:id])

	  authorize! :destroy, widget

    widget.destroy
    head :ok
  end

  def create_via_email

    # extract email address out of the from field
    email = params['from'].match("([a-z,A-Z,0-9,.,!,#,$,%,&,',*,+,-,\/,=,?,^,_,`,{,|,},~]*)@[a-z,A-Z,0-9,.,-]*")[0]
    
    canvas_id = params['to'].split('@').first
    user = User.find_by_email(email)
    widget = Widget.new(:canvas_id => canvas_id)

    if user && user.canvas_role?(widget.canvas,:member)
      
      widget = Widget.new(:canvas_id => canvas_id, :creator_id => user.id, :editor_id => user.id, :content_type => 'text_content', :text => params['text'])


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

  def feed_widget
    render :partial => "widgets/sections/content_page_edit", :object => @widget, :as => :widget
  end

end
