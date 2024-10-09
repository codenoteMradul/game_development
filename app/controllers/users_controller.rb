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
		flash[:notice] = "Account Created succesfully" 	
			redirect_to @user
		else
			render :new,status: :unprocessable_entity
			flash[:notice]= "Account Not Created"
		end
	end

	private
	def users_params					
		params.permit("username","age","city","phone","email","password")
	end
end