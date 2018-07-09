class ListingController < ApplicationController
  before_action :require_login, only: [:show]

  def index
    @lists = Listing.order(:id).page params[:page]
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
    Listing.find(params[:id]).delete
    redirect_to listing_index_path
  end

  def verify
    list = Listing.find(params[:id])
    list.update(verification: 1)
    redirect_to listing_path
  end

  def unverify
    list = Listing.find(params[:id])
    list.update(verification: 0)
    redirect_to listing_path
  end
  
  private
  def create_params
    params.require(:listing).permit(:name, :description, :price, :location)
  end

  def require_login
    unless signed_in?
      flash[:Error] = "You must be logged in to access this section"
      redirect_to sign_in_path
    end
  end
end