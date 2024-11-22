class UserMailer < ApplicationMailer
  default from: 'medicalapp72@gmail.com'

  def welcome_user(user)
    @user = user
    @greeting_text = "Welcome #{user} to Repository App!"
    mail(to: "#{user.email}", subject: "Welcome to Repository App")
  end
 
end