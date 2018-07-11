class ReservationController < ApplicationController
  def index
    @list = Listing.find(params[:listing_id])
    @reservation = Reservation.where(listing_id: params[:listing_id]).order(:id).page params[:page]
  end

  def create
    @reservation = Reservation.new(create_params)
    byebug
    @reservation.update(user_id: current_user.id, listing_id: params[:listing_id])
    if @reservation.save
      redirect_to listing_reservation_index_path
    else
      error_messages = @reservation.errors.messages
      error_messages.each do |key, value|
        flash[:"#{key}"] = value
      end
      redirect_to new_listing_reservation_path
    end
  end

  def new
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def destroy
    Reservation.find(params[:id]).delete
    redirect_to listing_index_path
  end

  private
  def create_params
    params.require(:reservation).permit(:date_in, :date_out)
  end
end
