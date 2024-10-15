class Invitation < ApplicationRecord
  belongs_to :user

	validates :email, format: { with: /\A(.+)@(.+)\z/, message: "Email invalid"  },uniqueness: { case_sensitive: false }
end
