class User < ApplicationRecord
	has_secure_password
   
  has_many :invitations
  has_many :eventlogs

  validates :username,format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" },presence: true
  validates :age, numericality: true,presence: true
  validates :city,format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" }
  validates :phone, numericality: true,presence: true,length: {maximum: 11},length: {minimum: 8}
  # validates :password,presence: true
  validates :email, format: { with: /\A(.+)@(.+)\z/, message: "Email invalid"  },uniqueness: { case_sensitive: false }
  validates :points, :numericality => { :greater_than_or_equal_to => -100 }

  after_save :rank_update, if: :saved_change_to_points?

  private
  def rank_update
    users = User.select("id, RANK() OVER(ORDER BY points DESC) AS ranks")
    user_ranks ={}
    users.each do |i|
      user_ranks[i.id] = i.ranks
    end
    user_details = User.where(id: user_ranks.keys)
    user_details.each do |user|
      user.update(rank: user_ranks[user.id])
    end
  end 
end
  