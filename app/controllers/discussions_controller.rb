class DiscussionsController < ApplicationController
  
  
  def show
    klass = eval(params[:type].capitalize)
    head :bad_request unless klass.respond_to?(:find)
    
    @obj = klass.find(params[:id])
    head :bad_request unless @obj.respond_to?(:opengraph_data)
    
    @href = params[:href]
    render :layout => false
  end
  
end
