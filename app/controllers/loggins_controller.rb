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
      session['name'] = @user.username
      after_authentication(@user)
		  redirect_to games_url
		else
		 flash[:alert] = "Invalid Id or Password"
		 redirect_to new_loggin_url
		end
	end

  private
  def after_authentication(user)
    Eventlog.create!(actions: "login",time: Time.current ,username: session['name'],user_id: user.id)
  end
end