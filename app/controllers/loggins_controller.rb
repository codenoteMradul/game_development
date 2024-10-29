class LogginsController < ApplicationController

	def index
	end

	def show
	end

	def new
	end
 
	def create
    begin
  	  @user = User.find_by(email: params[:email])
  	  if @user && @user.authenticate(params[:password])
        session['email'] = @user.email
        after_authentication(@user)
  		  redirect_to games_url
  		else
  		 flash[:alert] = "Invalid Id or Password"
  		 redirect_to new_loggin_url
  		end
    rescue StandardError => e
      flash[:alert] = "An error occurs:#{e.message}"
      redirect_to loggin_url
  	end
  end

  private
  def after_authentication(user)
    Eventlog.create!(actions: "login",time: Time.current ,username: session['name'],user_id: user.id)
  end
end