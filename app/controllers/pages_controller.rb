class PagesController < ApplicationController

	before_filter :require_login, :except => [:show, :index, :widgets]
	before_filter :load_canvas, :except => :destroy
  before_filter :only => [:show, :edit] do
    @page = Page.find(params[:id])
    @title = @page.canvas.name
  end

  def index
    @pages = Page.all
  end

  def show
  end

  def new
		@page = @canvas.pages.new
  end

  def edit
  end

  def versions
    @page = Page.find(params[:id])
  end

  def widgets
    page = Page.find(params[:id])
    @widgets = page.widgets.order("position asc")
    
    render :layout => false
  end

  def create
		@page = @canvas.pages.new(params[:page])
		@page.creator = current_user

    if @page.save
      redirect_to(edit_canvas_page_path(@canvas, @page), :notice => 'Page created!')
    else
      render :action => "new"
    end
  end

  def update
		@page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to(canvas_page_path(@canvas, @page), :notice => 'Page was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to(canvas_path(@canvas))
  end

	private 
	
	def load_canvas
		@canvas = Canvas.find(params[:canvas_id])
	end


end
