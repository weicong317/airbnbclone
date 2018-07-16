class PaymentMailer < ApplicationMailer
  def payment_made(user, reservation)
    @user = user
    @reservation = reservation
    mail(to: @user.email, subject: 'Payment Receipt')
  end
end
