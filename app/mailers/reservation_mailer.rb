class ReservationMailer < ApplicationMailer
  def welcome_email
    mail(to: "vuyev@creazionisa.com", subject: 'Welcome to My Awesome Site')
  end
end
