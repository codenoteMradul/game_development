class UserMailer < ApplicationMailer
	def invitation_mail(email)
		mail(to: email, subject: 'invite friends') 
	end
end
