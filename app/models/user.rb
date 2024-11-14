    class User < ApplicationRecord
	has_secure_password
   
  has_many :invitations
  has_many :eventlogs,dependent: :destroy

  validates :username,format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" },presence: true,uniqueness: true
  validates :age, numericality: true,presence: true
  validates :city,format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" }
  validates :phone, numericality: true,presence: true,length: {maximum: 11},length: {minimum: 8}
  validates :email, format: { with: /\A(.+)@(.+)\z/, message: "Email invalid"},uniqueness: true,presence: true
  validates :points, :numericality => { :greater_than_or_equal_to => -100 }

  after_save :rank_update, if: :saved_change_to_points?
  after_create :create_event_log

  def self.create_event_log(subject,user)
    Eventlog.create!(actions: subject ,username: user.username,time: Time.now,user_id: user.id) 
  end

  private
  
  def create_event_log
    Eventlog.create!(actions: "create account",user_id: id,username: username,time: Time.now)
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
  