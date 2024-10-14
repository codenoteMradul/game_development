class User < ApplicationRecord
	has_secure_password
  
  validates :username,format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" },presence: true
  validates :age, numericality: true,presence: true
  validates :city,format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" }
  validates :phone, numericality: true,presence: true,length: {maximum: 11},length: {minimum: 8}
  validates :password, length: {minimum: 4},presence: true
  validates :email, format: { with: /\A(.+)@(.+)\z/, message: "Email invalid"  },uniqueness: { case_sensitive: false }

end
