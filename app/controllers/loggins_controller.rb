class LogginsController < ApplicationController
  def new
  end

	def create
  	@user = User.find_by(email: params[:email])
  	if @user && @user.authenticate(params[:password])
      session['email'] = @user.email
      session['name'] = @user.username  
      User.create_event_log("login",@user)
  		redirect_to invitations_url
  	else
  		flash[:alert] = "Invalid Id or Password"
  		redirect_to new_loggin_url
  	end
  end
end
