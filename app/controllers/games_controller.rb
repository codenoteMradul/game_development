class GamesController < ApplicationController
  layout "logic"

	def index 
    @user = User.find_by(email: session[:email])  
	end


  def eventlog
    @events = Eventlog.where(username: session['name']).paginate(page: params[:page],per_page:10)
  end

	def lose
    @user = User.find_by(email: session['email'])
    @events = Eventlog.where(username: session['name']).paginate(page: params[:page],per_page:10)
	end

  def create
    user = User.find_by(email: session[:email])
    begin
      UserMailer.invitation_mail(params[:email]).deliver_now
      flash[:notice] = "Email sent"
      Invitation.invite(user,params[:email])
      User.create_event_log("send mail",user)
      Invitation.add_points(user)
    rescue StandardError => e
      flash[:notice] = "Error :#{e}"
      redirect_to games_url
    end
  end

  def leaderboard
    @rank = User.order(:rank).paginate(page: params[:page],per_page:4)
  end

  def point
    @score = params["point"].to_i
    session['get'] = @score

    @user = User.find_by(email: session[:email])
    if session['get'] == 50
      points_up = 50
      @user.update!(points: @user.points + points_up)
    else
      points_down = 100
      @user.update!(points: @user.points - points_down)
      User.create_event_log("game over", @user)
    end
    render js: <<~JS
      $('.points').text('#{@user.points}');
      window.location.href = '/games/start';
    JS
  end
  
  def game
    @user = User.find_by(email: session[:email])
    User.create_event_log("play game", @user)
  end			
end   