module ApplicationHelper
  def create_event_log(subject,user)
    Eventlog.create!(actions: subject ,username: user.username,time: Time.now,user_id: user.id) 
  end

  def add_points(user)
    user.update!(points: user.points + 200)
  end

  def invite(user)
    Invitation.create!(email: params[:email],user_id: user.id)
  end
end
