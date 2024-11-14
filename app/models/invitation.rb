class Invitation < ApplicationRecord
  belongs_to :user

  validates :email, format: { with: /\A(.+)@(.+)\z/, message: "Email invalid"  },presence: true,uniqueness: true

  def self.invite(user,email)
    Invitation.create!(email: email,user_id: user.id)
  end

  def self.add_points(user)
    user.update!(points: user.points + 200)
  end
end

