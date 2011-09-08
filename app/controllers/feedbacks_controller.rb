class FeedbacksController < ApplicationController
  # GET /feedbacks
  # GET /feedbacks.xml
  def index
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.xml
  def show
  end

  # GET /feedbacks/new
  # GET /feedbacks/new.xml
  def new
    # @feedback = Feedback.new
    # 
    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.xml  { render :xml => @feedback }
    # end
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks
  # POST /feedbacks.xml
  def create

    @feedback = Feedback.new
    @feedback.interested_in = params[:interested_in]
    @feedback.user_id = current_user
    
    respond_to do |format|
      if @feedback.save
        head :created
      else
        head :bad_request
      end
    end
  end

  # PUT /feedbacks/1
  # PUT /feedbacks/1.xml
  def update
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.xml
  def destroy
  end
end
