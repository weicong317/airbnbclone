class ReservationMailer < ApplicationMailer
  def reservation_made(user, reservation)
    @user = user
    @reservation = reservation
    mail(to: @user.email, subject: 'Thanks for your booking!')
  end
end
