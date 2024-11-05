class GamesController < ApplicationController
  include EventlogsAction
  layout "logic"

	def index 
	end

  def eventlog
    @event = Eventlog.where(username: session['name']).paginate(page: params[:page],per_page:10)
  end

	def lose
    @user = User.find_by(email: session['email'])
	end

  def leaderboard
    @rank = User.order(:rank).paginate(page: params[:page],per_page:4)
  end

  def point
    @score = params["point"].to_i
    session['get'] = @score
    @user = User.find_by(email: session[:email])
    if session['get'] == 50
      @user.update!(points: @user.points+50)
    else
      @user.update!(points: @user.points-100)
      redirect_to game_over_url
    end
  end
  
  def game
    @user = User.find_by(email: session[:email])
    after_start_game(@user)
  end			

	def create
    user = User.find_by(email: session[:email])
	  Invitation.find_by(email: params[:email])
    begin
  	  if UserMailer.invitation_mail(params[:email]).deliver_now
        flash[:notice] = "Email sent"
        after_mail_send(user)
        add_points(user)
  	  else
  	 	 flash[:alert] = "failed to sent mail"
  	 	 redirect_to games_url	
  	  end
    rescue StandardError => e 
     flash[:alert] = "An error occurs: #{e}"
    end
    redirect_to games_url
	end
end