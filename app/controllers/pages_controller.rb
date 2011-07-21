class PagesController < ApplicationController
  # GET /pages
  # GET /pages.xml

	before_filter :load_canvas, :except => :destroy


  def widgets
    page = Page.find(params[:id])
    @widgets = page.widgets
    
    render :layout => false
  end

  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    
		@page = @canvas.pages.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
		
		@page = @canvas.pages.new(params[:page])
		@page.creator = current_user

    respond_to do |format|
      if @page.save
        format.html { redirect_to(canvas_page_path(@canvas, @page), :notice => 'Page created!') }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update

		@page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to(canvas_page_path(@canvas, @page), :notice => 'Page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(canvas_path(@canvas)) }
      format.xml  { head :ok }
    end
  end

	
	private 
	
	def load_canvas
		@canvas = Canvas.find(params[:canvas_id])
	end


end
