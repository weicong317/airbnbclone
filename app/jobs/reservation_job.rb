class ReservationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ReservationMailer.welcome_email(current_user)
  end
end
