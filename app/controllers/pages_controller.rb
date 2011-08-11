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
    @widgets = Widget.for_page(@page.id)

    add_page_breadcrumb(@page)
  end

  def edit
		add_breadcrumb "Edit '#{@page.title}'", edit_canvas_page_path(@page.canvas, @page)
  end

  def versions
    add_breadcrumb "Versions of '#{@page.title}'", versions_canvas_page_path(@page.canvas, @page)
  end

  def new
    canvas = Canvas.find(params[:canvas_id])
    @page = Page.new
    @page.canvas = canvas
		
		add_canvas_breadcrumb(canvas)
		add_breadcrumb "Add Page", new_canvas_page_path(canvas)
  end
  
  def create
    canvas = Canvas.find(params[:canvas_id])
    @page = canvas.pages.new(params[:page])
		@page.creator = current_user

    if @page.save
      redirect_to(edit_canvas_page_path(@page.canvas, @page), :notice => 'Page created!')
    else
      render :action => "new"
    end
  end

  def update
		@page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to(canvas_page_path(@page.canvas, @page), :notice => 'Page was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to(canvas_path(@page.canvas))
  end

end
