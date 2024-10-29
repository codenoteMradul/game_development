class GamesController < ApplicationController
  layout "logic"

	def index 
	end

  def eventlog
   @event = Eventlog. where(username: session['name'])
  end

	def lose
   @user = User.find_by(email: session[:email])
	end

  def leaderboard
   @rank = User.order(:rank) 
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
    flash[:alert] = "An error occurs: #{e.message}"
   end
   redirect_to games_url
	end

  private
  def after_mail_send(user)
   Eventlog.create!(actions: "send mail",username: user.username,time: Time.now,user_id: user.id) 
  end
  def after_start_game(user)
   Eventlog.create!(actions: "play game",username: user.username,time: Time.now,user_id: user.id) 
  end 

  def add_points(user)
    User.update!(points: user.points + 200)
  end
end