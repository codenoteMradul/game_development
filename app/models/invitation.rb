class Invitation < ApplicationRecord
  belongs_to :user
  validates :email, format: {with: /[A-Za-z0-9+_.-]+@([A-Za-z0-9]+\.)+[A-Za-z]{2,6}/, message: "invalid"}, 
            uniqueness: {case_sensitive: false}, 
            length: {minimum: 4, maximum: 254}         

  after_create :invite_friends
  after_create :invitation_event_log
  after_create :add_points

  private

  def invitation_event_log
    Eventlog.create!(actions:"send invitation", user_id: user.id, username: user.username, time: Time.now)
  end

  def invite_friends
    UserMailer.invitation_mail(email).deliver_now
  end

  def add_points
    @user = User.find_by(email: user.email)
    @user.update!(points: user.points + 200)  
  end
end
