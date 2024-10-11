class Invitation < ApplicationRecord
	validates :email, format: { with: /\A(.+)@(.+)\z/, message: "Email invalid"  },uniqueness: { case_sensitive: false }
end
