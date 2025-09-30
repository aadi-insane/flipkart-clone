class UserMailer < ApplicationMailer
  def address_reminder(user)
    @user = user
    mail(to: @user.email, subject: "Don't forget to add your address!")
  end
end