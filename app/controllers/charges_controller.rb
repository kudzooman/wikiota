class ChargesController < ApplicationController

  def create

    @amount = params[:amount]

    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )
    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "Premium Wikiota Membership - #{current_user.name}",
      currency: 'usd' 
      )

    current_user.update_attribute(:role, "premium")

    redirect_to articles_path, flash: { notice: "Thanks for your payment, #{current_user.name}!" } # or wherever

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
