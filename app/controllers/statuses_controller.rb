class StatusesController < ApplicationController
	def create
		status = Status.new(status_params)
		status.user_id = current_user.id

		flash[:error] = "Your Status was over 140 characters" unless status.save
		redirect_to root_url
	end

	def status_params
		params.require(:status).permit(:content)
	end
end
