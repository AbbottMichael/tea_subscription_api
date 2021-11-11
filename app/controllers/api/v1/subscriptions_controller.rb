class Api::V1::SubscriptionsController < ApplicationController

  def index
    customer = Customer.find_by(id: params[:customer_id].to_i)
    if !customer.nil?
      subscriptions = customer.subscriptions
      render json: SubscriptionSerializer.new(subscriptions)
    else
      render json: { error: 'The customer does not exist' }, status: :not_found
    end
  end

  def create
    subscription = Subscription.new(subscription_params)
      if subscription.save
        render json: SubscriptionSerializer.new(subscription)
      else
        render json: { error: "Please provide the required inputs" }, status: :bad_request
      end
  end

  def update
    subscription = Subscription.find_by(id: params[:id].to_i)
    if !subscription.nil? && subscription.status == subscription_params[:status]
      render json: { error: 'This subscription currently has the requested status. No change made.' }, status: :bad_request
    elsif !subscription.nil?
      subscription.update(subscription_params)
      render json: SubscriptionSerializer.new(subscription)
    else
      render json: { error: 'The subscription does not exist' }, status: :not_found
    end
  end

  private

  def subscription_params
    params.
    require(:subscription).
    permit(:frequency, :ounces, :tea_id, :customer_id, :address_id, :status)
  end
end
