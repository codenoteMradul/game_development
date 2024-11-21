class LogginsController < ApplicationController
  def new
  end

	def create
    begin
  	  @user = User.find_by(email: params[:email])
  	  if@user && @user.authenticate(params[:password])
        session['email'] = @user.email
        session['name'] = @user.username  
        User.create_event_log("login",@user)
  		  redirect_to invitations_url
  		else
  		 flash[:alert] = "Invalid Id or Password"
  		 redirect_to new_loggin_url
  		end
    rescue StandardError => e
      flash[:alert] = "An error occurs:#{e.message}"
      redirect_to loggin_url
  	end
  end
end
