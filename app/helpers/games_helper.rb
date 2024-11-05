module EventlogsAction
  def after_authentication(user)
    Eventlog.create!(actions: "login",time: Time.now ,username: user.username,user_id: user.id)
  end

  def after_mail_send(user)
    Eventlog.create!(actions: "send mail",username: user.username,time: Time.now,user_id: user.id) 
  end

  def after_start_game(user)
    Eventlog.create!(actions: "play game",username: user.username,time: Time.now,user_id: user.id) 
  end
   
  def add_points(user)
    user.update!(points: user.points + 200)
  end
end