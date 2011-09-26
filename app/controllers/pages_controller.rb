class PagesController < ApplicationController

	before_filter :require_login, :except => [:show, :index]
  before_filter :only => [:show, :edit, :versions] do
    @page = Page.find(params[:id])
		# for header in application layout
    @title = @page.canvas.name
    @canvas = @page.canvas
		add_canvas_breadcrumb(@page.canvas)
  end

  def show
    authorize! :read, @page
    
    @widgets = Widget.for_page(@page.id)
    add_page_breadcrumb(@page)
  end

  def edit
    authorize! :update, @page
    
    # Create a blank widget for each widget type.
    @new_widgets = {
      :text_widget => Widget.new(:content_type => "text_content", :page => @page),
      :image_widget => Widget.new(:content_type => "image_content", :page => @page),
      :link_widget => Widget.new(:content_type => "link_content", :canvas => @canvas),
      :question_widget => Widget.new(:content_type => "question_content", :canvas => @canvas)
    }
		add_breadcrumb "Edit '#{@page.title}'", edit_canvas_page_path(@page.canvas, @page)
		
    
  end

  def versions
    add_breadcrumb "Versions of '#{@page.title}'", versions_canvas_page_path(@page.canvas, @page)
  end

  def new
    
    canvas = Canvas.find(params[:canvas_id])
    authorize! :create, Page.new(:canvas => canvas)
    
    @page = Page.new
    @page.canvas = canvas
		
		add_canvas_breadcrumb(canvas)
		add_breadcrumb "Add Page", new_canvas_page_path(canvas)
  end
  
  def create
    canvas = Canvas.find(params[:canvas_id])

    authorize! :create, Page.new(:canvas => canvas)

    @page = canvas.pages.new(params[:page])

		@page.creator = current_user
		@page.editor = current_user

    if @page.save
      redirect_to(edit_canvas_page_path(@page.canvas, @page), :notice => 'Page created!')
    else
      render :action => "new"
    end
  end

  def update
		@page = Page.find(params[:id])

		authorize! :update, @page

    if @page.update_attributes(params[:page].merge(:editor_id => current_user.id))
      redirect_to(canvas_page_path(@page.canvas, @page), :notice => 'Page was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    authorize! :destroy, @page
    
    @page.destroy
    redirect_to(canvas_path(@page.canvas))
  end

end
