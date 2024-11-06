class GamesController < ApplicationController
  include ApplicationHelper
  layout "logic"

	def index 
	end

  def eventlog
    @event = Eventlog.where(username: session['name']).paginate(page: params[:page],per_page:10)
  end

	def lose
    @user = User.find_by(email: session['email'])
    @event = Eventlog.where(username: session['name']).paginate(page: params[:page],per_page:10)
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
      create_event_log("game over", @user)
    end
  end
  
  def game
    @user = User.find_by(email: session[:email])
    create_event_log("play game", @user)
  end			

	def create
    user = User.find_by(email: session[:email])
    begin
  	  if UserMailer.invitation_mail(params[:email]).deliver_now
        flash[:notice] = "Email sent"
        invite(user)
        create_event_log("send mail", user)
        add_points(user)
      else
  	 	 flash[:alert] = "failed to sent mail"
  	  end
    rescue StandardError => e 
     flash[:alert] = "An error occurs: #{e}"
    end
    redirect_to games_url
	end
end