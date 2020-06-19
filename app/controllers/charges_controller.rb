class ChargesController < ApplicationController
  def new
  end
  
  def create
    # Amount in cents
    @amount = 50
    @user = current_user
  
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
  
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })
  
    MoneyPot.add_money(@user, @amount)

    redirect_to user_money_pot_path(current_user.id, current_user.money_pot.id)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end  
end
