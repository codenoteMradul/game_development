class Invitation < ApplicationRecord
  belongs_to :user

  validates :email, format: { with: /\A(.+)@(.+)\z/, message: "Email invalid"  },presence: true,uniqueness: true
end

