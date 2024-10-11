class LogginsController < ApplicationController

	def index
	end

	def show
	end

	def new
	end
 
	def create
		@user = User.find_by(email: params[:email])
		if @user && @user.authenticate(params[:password])
			redirect_to games_url
		else
			flash[:alert] = "Invalid Id or Password"
			redirect_to new_loggin_url
		end
	end
end