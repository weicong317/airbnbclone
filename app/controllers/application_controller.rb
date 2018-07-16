class ApplicationController < ActionController::Base
  include Clearance::Controller

  private
  def require_login
    unless signed_in?
      flash[:Error] = "You must be logged in to access this section"
      redirect_to sign_in_path
    end
  end
end
