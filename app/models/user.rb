class User < ApplicationRecord
	has_secure_password
   
  has_many :invitations
  has_many :eventlogs,dependent: :destroy

  validates :username, uniqueness: true
  validates :email, format: {with: /[A-Za-z0-9+_.-]+@([A-Za-z0-9]+\.)+[A-Za-z]{2,6}/, message: "invalid"}, 
            uniqueness: {case_sensitive: false}, 
            length: {minimum: 4, maximum: 254} 

  after_save :rank_update, if: :saved_change_to_points?
  after_create :create_event_log

  def self.create_event_log(subject,user)
    Eventlog.create!(actions: subject , username: user.username, time: Time.now, user_id: user.id) 
  end

  private
  
  def create_event_log
    Eventlog.create!(actions: "create account", user_id: id, username: username, time: Time.now)
  end

  def rank_update
    users = User.select("id, RANK() OVER(ORDER BY points DESC) AS ranks")
    user_ranks = {}
    users.each do |i|
      user_ranks[i.id] = i.ranks
    end
    user_details = User.where(id: user_ranks.keys)
    user_details.each do |user|
      user.update(rank: user_ranks[user.id])
    end
  end 
end
  