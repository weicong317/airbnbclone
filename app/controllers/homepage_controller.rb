class HomepageController < ApplicationController
  def index
  end

  def about
    ReservationJob.perform_later(current_user)
    #auto render about
  end
end
