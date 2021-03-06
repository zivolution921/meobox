class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents    
    @amount = params[:plan_price].to_i * 100    

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    user = User.find_by(email: params[:stripeEmail])
    user.update_attributes(stripe_token: params[:stripeToken])

    redirect_to :back

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end  
end
