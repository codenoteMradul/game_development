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
			redirect_to '/games'
		else
			redirect_to '/users'
		end
	end
end