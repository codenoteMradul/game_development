class GamesController < ApplicationController
	def index
	end
  
  def game
  end

	def create
	 @invitation = Invitation.find_by(email: params[:email])	
	 if UserMailer.invitation_mail(params[:email]).deliver_now
	 	flash[:alert] = "email send"
	 	redirect_to games_url
	 else
	 	binding.pry
	 	flash[:alert] = "email is not valid"
	 	redirect_to games_url	
	 end
	end
end