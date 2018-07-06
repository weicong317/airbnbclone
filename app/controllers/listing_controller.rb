class ListingController < ApplicationController
  def index
  end

  def create
    @listing = Listing.new(create_params)
    @listing.update(user_id: current_user.id)
    if @listing.save
      redirect_to listing_index_path
    else
      error_messages = @listing.errors.messages
      error_messages.each do |key, value|
        flash[:"#{key}"] = value
      end
      redirect_to new_listing_path
    end
  end
  
  def new
  end
  
  def edit
  end
  
  def show
  end
  
  def update
    @listing = Listing.update(create_params)
    redirect_to "/listing/#{params[:id]}"
  end

  def destroy
    Listing.find(params[:id].to_i).delete
    redirect_to listing_index_path
  end

  private
  def create_params
    params.require(:listing).permit(:name, :description, :price, :location)
  end
end
