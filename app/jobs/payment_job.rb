class PaymentJob < ApplicationJob
  queue_as :default

  def perform(*args)
    PaymentMailer.payment_made(args[0], args[1]).deliver_now
  end
end
