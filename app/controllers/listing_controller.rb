class ListingController < ApplicationController
  before_action :require_login, only: [:create, :new, :edit, :update, :destroy, :verify, :unverify]

  def index
    @lists = Listing.verification
    if params[:search]
      if search_params[:country].present?
        @lists = Listing.country(search_params[:country].downcase).order(:id).reverse_order.page params[:page]
        if ISO3166::Country.find_country_by_name(search_params[:country])
          if @lists === []
            flash.now[:notice] = "No room available in #{search_params[:country]} yet!"
            @lists = Listing.verification.order(:id).reverse_order.page params[:page]
          end
        else
          flash.now[:notice] = "No such country!"
          @lists = Listing.verification.order(:id).reverse_order.page params[:page]
        end
      else
        @lists = @lists.order(:id).reverse_order.page params[:page]
      end
    else
      @lists = @lists.order(:id).reverse_order.page params[:page]
    end
  end
  
  def filter
    @lists = Listing.verification
    @lists = @lists.price(filter_params[:price]) if filter_params[:price].present?
    @lists = @lists.amenities(filter_params[:amenities]) if filter_params[:amenities].present?
    
    if filter_params[:country].present?
      @lists = @lists.country(filter_params[:country].downcase)
      if ISO3166::Country.find_country_by_name(filter_params[:country])
        if @lists.empty?
          flash.now[:notice] = "No room available in #{filter_params[:country]} yet!"
        end
      else
        flash.now[:notice] = "No such country!"
        @lists = []
      end
    end
    @lists = @lists.order(:id).reverse_order.page params[:page]
    
    respond_to do |format|
      format.html {render :index}
      format.js
    end
  end
  
  def autocomplete
    @lists = Listing.verification
    @lists = @lists.starts_with(filter_params[:country]) if filter_params[:country].present? 
    
    respond_to do |format|
      format.json {render json:@lists}
    end
  end

  def create
    @listing = Listing.new(create_params)
    @listing.update(user_id: current_user.id, country: ISO3166::Country.new(create_params[:country]).name.downcase)
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

  def filter_params
    params.require(:search).permit(:country, :price, amenities: [])
  end
end