class InvitationsController < ApplicationController
   
  def index
    @user = User.find_by(email: session[:email])
  end

  def rules
  end

  def eventlog
    @events = Eventlog.where(username: session['name']).paginate(page: params[:page], per_page:10)
  end

  def leaderboard
    @rank = User.order(:rank).paginate(page: params[:page], per_page:4)
  end

  def create
    @user = User.find_by(email: session[:email])
    invitation = Invitation.new(email: params[:email], user_id: @user.id)
    if invitation.save
      flash[:notice] = "Email sent"
    else
      flash[:error] = invitation.errors.full_messages 
    end
    redirect_to invitations_url
  end
end
