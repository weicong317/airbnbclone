class ListingController < ApplicationController
  before_action :require_login, only: [:create, :new, :edit, :update, :destroy, :verify, :unverify]

  def index
    if params[:search]
      temp = search_params[:country]
      if ISO3166::Country.find_country_by_name(temp)
        country_code = ISO3166::Country.find_country_by_name(temp).alpha2
        @lists = Listing.where("country = '#{country_code}' AND verification = true").order(:id).reverse_order.page params[:page]
      else
        flash.now[:notice] = " No such country!"
        @lists = Listing.where(verification: 1).order(:id).reverse_order.page params[:page]
      end
    else
      @lists = Listing.where(verification: 1).order(:id).reverse_order.page params[:page]
    end
  end

  def create
    @listing = Listing.new(create_params)
    @listing.update(user_id: current_user.id)
    if @listing.save
      redirect_to listing_index_path
    else
      error_messages = @listing.errors.messages
      error_messages.each do |key, value|
        flash.now[:"#{key}"] = value
      end
      redirect_to new_listing_path
    end
  end
  
  def new
  end
  
  def edit
    @list = Listing.find(params[:id])
  end
  
  def show
    @list = Listing.find(params[:id])
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
    list.update(verification: nil)
    redirect_to listing_path
  end
  
  private
  def create_params
    params.require(:listing).permit(:name, :description, :price, :address, :country, :remove_rooms, {rooms: []}, amenities: [])
  end

  def search_params
    params.require(:search).permit(:country)
  end
end