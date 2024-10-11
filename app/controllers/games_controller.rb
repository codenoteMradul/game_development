class GamesController < ApplicationController
	def index
	end
  
  def show
  end

	def create
	 @invitation = Invitation.find_by(email: params[:email])
	 if UserMailer.new.invitation_mail(params[:email])
	 	flash[:alert] = "email send"
	 	redirect_to games_url
	 else
	 	flash[:alert] = "email is not valid"
	 	redirect_to games_url	
	 end

	 

	end

end