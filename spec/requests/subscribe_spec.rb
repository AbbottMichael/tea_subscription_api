require 'rails_helper'

RSpec.describe "subscribe endpoint" do
  before :each do
    @customer_1 = Customer.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com"
    )
    @address_1 = @customer_1.addresses.create!(
      type_of: "shipping",
      address_1: "1000 Awesome Pl",
      address_2: "1",
      city: "Seattle",
      state: "WA",
      zip_code: "91234"
    )
    @tea_1 = Tea.create!(
      title: "Green",
      description: "It is green.",
      temperature: 175,
      brew_time: 120,
      price_oz: 400
    )
  end

  describe "subscribe a customer to a tea subscription" do
    it "creates a customer tea subscription" do
      body = {
          subscription: {
            frequency: "monthly",
            ounces: 2,
            tea_id: @tea_1.id,
            customer_id: @customer_1.id,
            address_id: @address_1.id
          }
      }

      post "/api/v1/subscriptions", params: body, as: :json

      expect(response).to be_successful
      # expect(response.status).to eq(200)
      # subscription_info = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
