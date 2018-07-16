class UserJob < ApplicationJob
  queue_as :default

  def perform(*args)
    UserMailer.welcome_email(args[0]).deliver_now
  end
end
