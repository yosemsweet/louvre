class CanvaeController < ApplicationController
  # GET /canvae
  # GET /canvae.xml
  def index
    @canvae = Canvas.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @canvae }
    end
  end

  # GET /canvae/1
  # GET /canvae/1.xml
  def show
    @canvas = Canvas.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @canvas }
    end
  end

  # GET /canvae/new
  # GET /canvae/new.xml
  def new
    @canvas = Canvas.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @canvas }
    end
  end

  # GET /canvae/1/edit
  def edit
    @canvas = Canvas.find(params[:id])
  end

  # POST /canvae
  # POST /canvae.xml
  def create
    @canvas = Canvas.new(params[:canvas])

    respond_to do |format|
      if @canvas.save
        format.html { redirect_to(@canvas, :notice => 'Canvas was successfully created.') }
        format.xml  { render :xml => @canvas, :status => :created, :location => @canvas }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @canvas.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /canvae/1
  # PUT /canvae/1.xml
  def update
    @canvas = Canvas.find(params[:id])

    respond_to do |format|
      if @canvas.update_attributes(params[:canvas])
        format.html { redirect_to(@canvas, :notice => 'Canvas was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @canvas.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /canvae/1
  # DELETE /canvae/1.xml
  def destroy
    @canvas = Canvas.find(params[:id])
    @canvas.destroy

    respond_to do |format|
      format.html { redirect_to(canvae_url) }
      format.xml  { head :ok }
    end
  end
end
