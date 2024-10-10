class UsersController < ApplicationController
	def index
	end
  
  def show
  end

	def new
		@user = User.new
	end

	def create
		@user = User.new(users_params)
		if @user.save
		flash[:notice] = "Account is succesfully Created" 	
			redirect_to @user
		else
			flash[:notice] = "Account Not Created"
			render :new,status: :unprocessable_entity
		end
	end

	private
	def users_params					
		params.permit("username","age","city","phone","email","password")
	end
end