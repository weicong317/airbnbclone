class ReservationMailer < ApplicationMailer
  def welcome_email(user)
    @user =user
    mail(to: "vuyev@creazionisa.com", subject: 'Welcome to My Awesome Site')
  end
end
