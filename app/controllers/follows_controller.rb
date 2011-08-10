class FollowsController < ApplicationController

	before_filter do
		@status = :ok
		
		begin 
			followable_class = params[:followable_type].capitalize.constantize
		rescue
			@status = :bad_request
		end
		
		begin
			@object_to_follow = followable_class.find(params[:followable_id])
		rescue
			@status = :bad_request
		end
		
	end

	def create
		
		begin			
			current_user.follow(@object_to_follow)
		rescue
			@status = :bad_request
		end
		
		head @status
	end
	
	def delete
		
		begin			
			current_user.stop_following(@object_to_follow)
		rescue
			@status = :bad_request
		end
		
		head @status
	end

end
