class PagesController < ApplicationController

	before_filter :require_login, :except => [:show, :index, :widgets]
  before_filter :only => [:show, :edit, :versions, :widgets] do
    @page = Page.find(params[:id])
    @title = @page.canvas.name
  end

  def show
    @widgets = @page.widgets_in_order
  end

  def edit
  end

  def versions
  end

  def widgets
    @widgets = @page.widgets_in_order
    render :layout => false
  end

  def new
    canvas = Canvas.find(params[:canvas_id])
    @page = Page.new
    @page.canvas = canvas
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
