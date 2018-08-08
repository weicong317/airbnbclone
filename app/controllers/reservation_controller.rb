class ReservationController < ApplicationController
  before_action :require_login

  def create
    overlapping = 0
    # dont allow current user to book his own room
    if current_user.id != Listing.find(params[:listing_id]).user.id
      @reservation = Reservation.new(create_params)
      # to check has the date being taking
      Reservation.where(listing_id: params[:listing_id]).each do |row|
        if row.date_in <= @reservation.date_out && @reservation.date_in <= row.date_in
          overlapping = 1
          break
        end
      end
      if overlapping === 0
        @reservation.update(user_id: current_user.id, listing_id: params[:listing_id], payment: false)
        if @reservation.save
          # send email to inform the reservation is made
          ReservationJob.perform_later(current_user, @reservation)
          redirect_to reservation_path(@reservation.id)
        else
          error_messages = @reservation.errors.messages
          error_messages.each do |key, value|
            flash.now[:"#{key}"] = value
          end
          redirect_to listing_path(params[:listing_id])
        end
      else
        flash.now[:notice] = "Chosen date has been taken!"
        redirect_to listing_path(params[:listing_id])
      end
    else
      flash.now[:notice] = "You are the owner of the room!"
      redirect_to listing_path(params[:listing_id])
    end
  end

  def update
    Reservation.find(params[:id]).update(create_params)
    redirect_to reservation_path(params[:id])
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
