class GamesController < ApplicationController
	def index
	render

	def lose
	end
  
  def game
    @point = User.last
  end			

	def create
	 @invitation = Invitation.find_by(email: params[:email])	
	 if UserMailer.invitation_mail(params[:email]).deliver_now
	  if params[:email].blank?
  	 	 flash[:alert] = "email can't be blank"
  	 	 redirect_to games_url
  	 else
  	 	flash[:alert] = "email send"
  	 	redirect_to games_url
  	 end
	 else
	 	flash[:alert] = "email is not valid"
	 	redirect_to games_url	
	 end
	end
 end
end