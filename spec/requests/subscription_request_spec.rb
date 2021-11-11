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
    @subscription_1 = @customer_1.subscriptions.create!(
      frequency: 30,
      ounces: 2,
      tea_id: @tea_1.id,
      address_id: @address_1.id
    )
  end

  describe "subscribe a customer to a tea subscription" do
    it "creates a customer tea subscription" do
      body = {
          subscription: {
            frequency: 30,
            ounces: 2,
            tea_id: @tea_1.id,
            customer_id: @customer_1.id,
            address_id: @address_1.id
          }
      }

      post "/api/v1/subscriptions", params: body, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)
      subscription_info = JSON.parse(response.body, symbolize_names: true)

      expect(subscription_info).to have_key(:data)
      expect(subscription_info[:data]).to be_a(Hash)
      expect(subscription_info[:data].keys.count).to eq(3)
      expect(subscription_info[:data]).to have_key(:id)
      expect(subscription_info[:data][:id]).to be_a(String)
      expect(subscription_info[:data]).to have_key(:type)
      expect(subscription_info[:data][:type]).to eq("subscription")
      expect(subscription_info[:data]).to have_key(:attributes)
      expect(subscription_info[:data][:attributes]).to be_a(Hash)
      expect(subscription_info[:data][:attributes].keys.count).to eq(7)
      expect(subscription_info[:data][:attributes]).to have_key(:price)
      expect(subscription_info[:data][:attributes][:price]).to be_an(Integer)
      expect(subscription_info[:data][:attributes]).to have_key(:status)
      expect(subscription_info[:data][:attributes][:status]).to eq('active')
      expect(subscription_info[:data][:attributes]).to have_key(:frequency)
      expect(subscription_info[:data][:attributes][:frequency]).to be_an(Integer)
      expect(subscription_info[:data][:attributes]).to have_key(:ounces)
      expect(subscription_info[:data][:attributes][:ounces]).to be_an(Integer)
      expect(subscription_info[:data][:attributes]).to have_key(:customer_id)
      expect(subscription_info[:data][:attributes][:customer_id]).to eq(@customer_1.id)
      expect(subscription_info[:data][:attributes]).to have_key(:tea_id)
      expect(subscription_info[:data][:attributes][:tea_id]).to eq(@tea_1.id)
      expect(subscription_info[:data][:attributes]).to have_key(:address_id)
      expect(subscription_info[:data][:attributes][:address_id]).to eq(@address_1.id)
    end
  end

  it "cancels a customer's tea subscription" do
    patch "/api/v1/subscriptions/#{@subscription_1.id}", params: body, as: :json

    expect(response).to be_successful
  end
end
