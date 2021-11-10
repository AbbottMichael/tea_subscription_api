class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :status,
             :frequency,
             :ounces,
             :customer_id,
             :tea_id,
             :address_id

  attribute :price do |object|
    object.calculate_price
  end
end
