class User < ApplicationRecord
	has_secure_password
  
  # before_save :downcase_email

	# validates :username,format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" }, length: {minimum: 2},presence: true
  # validates :age, numericality: true,presence: true
  # validates :city, length: {minimum: 2},presence: true
  # validates :phone, numericality: true,presence: true,length: {maximum: 11},length: {minimum: 8}
  # validates :password, length: {minimum: 4},presence: true


 # private
 # def downcase_email
 # 	email = email.downcase
 # end
 
end
