class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
    @reservation = Reservation.find(params[:id])
  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
    result = Braintree::Transaction.sale(
     :amount => params[:checkout_form][:amount],
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )

    if result.success?
      PaymentJob.perform_later(current_user, Reservation.find(params[:id]))
      Reservation.find(params[:id]).update(payment: true)
      redirect_to listing_path(params[:listing_id]), :flash.now => { :success => "Transaction successful!" }
    else
      redirect_to listing_path(params[:listing_id]), :flash.now => { :error => "Transaction failed. Please try again." }
    end
  end
end