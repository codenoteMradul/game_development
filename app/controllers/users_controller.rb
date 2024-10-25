	class UsersController < ApplicationController
	def index  
   @rank = User.order(:rank)
	end
  
  def show
  end
  
  def point
  end
  
	def new
	 @user = User.new
	end

	def create
		@user = User.new(users_params)
		if @user.save
		 flash[:alert] = "Account Is Succesfully Created" 	
		 redirect_to @user
		else
		 flash[:warning] = "Account Not Created"
		 render :new,status: :unprocessable_entity
		end
	end

	private
	def users_params					
		params.permit("username","age","city","phone","email","password")
	end
end