class HomepageController < ApplicationController
  def index
  end

  def about
    ReservationMailer.welcome_email.deliver_now
  end
end
