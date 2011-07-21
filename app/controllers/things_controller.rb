class ThingsController < ApplicationController
  before_filter :load_canvas, :except => :destroy
  
  # GET /things
  # GET /things.xml
  
  def index
    @things = @canvas.things.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @things }
    end
  end

  # GET /things/1
  # GET /things/1.xml
  def show
    @thing = @canvas.things.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @thing }
    end
  end

  # GET /things/new
  # GET /things/new.xml
  def new
    @thing = @canvas.things.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @thing }
    end
  end

  # GET /things/1/edit
  def edit
    @thing = @canvas.things.find(params[:id])
  end

  # POST /things
  # POST /things.xml
  def create
    @thing = @canvas.things.new(params[:thing])

    respond_to do |format|
      if @thing.save
        format.html { redirect_to(@thing, :notice => 'Thing was successfully created.') }
        format.xml  { render :xml => @thing, :status => :created, :location => @thing }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @thing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /things/1
  # PUT /things/1.xml
  def update
    @thing = @canvas.things.find(params[:id])

    respond_to do |format|
      if @thing.update_attributes(params[:thing])
        format.html { redirect_to(@thing, :notice => 'Thing was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.xml
  def destroy
    @thing = @canvas.things.find(params[:id])
    @thing.destroy

    respond_to do |format|
      format.html { redirect_to(things_url) }
      format.xml  { head :ok }
    end
  end
  
  private 
	
	def load_canvas
		@canvas = Canvas.find(params[:canvas_id])
	end
  
  
end
