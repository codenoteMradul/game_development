class Invitation < ApplicationRecord
  belongs_to :user
  validates :email, presence: true, uniqueness: true

  after_create :invite_fiends

  def invite_friends(user)
    binding.pry
    Invitation.add_points(user)
  end

  def self.invite(user,email)
    Invitation.create!(email: email,user_id: user.id)
  end

  def self.add_points(user)
    user.update!(points: user.points + 200)
  end
end

