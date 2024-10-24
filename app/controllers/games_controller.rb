class GamesController < ApplicationController
	def index 
	end

	def lose
    @user = User.find_by(email: session[:email])
	end

  def leaderboard
   @rank = User.order(:rank)
  end

  def point
   session['get'] = 0
   @score = params["point"].to_i
   session['get'] = @score
     if session['get'] == 50
       @user = User.find_by(email: session[:email])
       @user.update!(points: @user.points+50)
     else
       @user = User.find_by(email: session[:email])
       @user.update!(points: @user.points-100)
       redirect_to leaderboard_url
     end
  end
  
  def game
   @user = User.find_by(email: session[:email])
  end			

	def create
	 Invitation.find_by(email: params[:email])	
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