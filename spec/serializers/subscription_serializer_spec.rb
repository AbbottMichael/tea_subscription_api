require 'rails_helper'

RSpec.describe SubscriptionSerializer do
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
    @subscription_1 = Subscription.create!(
      frequency: 30,
      ounces: 2,
      tea_id: @tea_1.id,
      customer_id: @customer_1.id,
      address_id: @address_1.id
    )
  end

  it "returns a formatted response" do
    returned = SubscriptionSerializer.new(@subscription_1)
    response = JSON.parse(returned.to_json, symbolize_names: true)

    expect(response).to have_key(:data)
    expect(response[:data]).to be_a(Hash)
    expect(response[:data].keys.count).to eq(3)
    expect(response[:data]).to have_key(:id)
    expect(response[:data][:id]).to be_a(String)
    expect(response[:data]).to have_key(:type)
    expect(response[:data][:type]).to eq("subscription")
    expect(response[:data]).to have_key(:attributes)
    expect(response[:data][:attributes]).to be_a(Hash)
    expect(response[:data][:attributes].keys.count).to eq(7)
    expect(response[:data][:attributes]).to have_key(:price)
    expect(response[:data][:attributes][:price]).to be_an(Integer)
    expect(response[:data][:attributes]).to have_key(:status)
    expect(response[:data][:attributes][:status]).to eq('active')
    expect(response[:data][:attributes]).to have_key(:frequency)
    expect(response[:data][:attributes][:frequency]).to be_an(Integer)
    expect(response[:data][:attributes]).to have_key(:ounces)
    expect(response[:data][:attributes][:ounces]).to be_an(Integer)
    expect(response[:data][:attributes]).to have_key(:customer_id)
    expect(response[:data][:attributes][:customer_id]).to eq(@customer_1.id)
    expect(response[:data][:attributes]).to have_key(:tea_id)
    expect(response[:data][:attributes][:tea_id]).to eq(@tea_1.id)
    expect(response[:data][:attributes]).to have_key(:address_id)
    expect(response[:data][:attributes][:address_id]).to eq(@address_1.id)
  end
end
