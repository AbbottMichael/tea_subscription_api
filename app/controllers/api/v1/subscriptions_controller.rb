class Api::V1::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.new(subscription_params)
      if subscription.save
        render json: SubscriptionSerializer.new(subscription)
      else
        render json: { error: "Please provide the correct inputs" }, status: :not_found
      end
  end

  private

  def subscription_params
    params.
    require(:subscription).
    permit(:frequency, :ounces, :tea_id, :customer_id, :address_id, :status)
  end
end
