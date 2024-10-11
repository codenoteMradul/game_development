class UserMailer < ApplicationMailer
	def invitation_mail(email)
		mail(to: email , subject: 'invitation for a game')
	end
end