class ReservationJob < ApplicationJob
  queue_as :default

  def perform(*args)    
    ReservationMailer.reservation_made(args[0], args[1]).deliver_now
  end
end
