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
      session['email'] = @user.email
		 redirect_to games_url
		else
		 flash[:alert] = "Invalid Id or Password"
		 redirect_to new_loggin_url
		end
	end

  private
  def after_authentication(user)
    Eventlog.create!(actions: "login",time: Time.now)
  end
end