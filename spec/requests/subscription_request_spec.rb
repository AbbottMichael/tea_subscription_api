require 'rails_helper'

RSpec.describe "subscription endpoint" do
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
    @tea_2 = Tea.create!(
      title: "Black",
      description: "It is black.",
      temperature: 195,
      brew_time: 90,
      price_oz: 500
    )
    @subscription_1 = @customer_1.subscriptions.create!(
      frequency: 30,
      ounces: 2,
      tea_id: @tea_1.id,
      address_id: @address_1.id
    )
    @subscription_2 = @customer_1.subscriptions.create!(
      status: 'cancelled',
      frequency: 30,
      ounces: 4,
      tea_id: @tea_2.id,
      address_id: @address_1.id
    )
  end

  describe "POST" do
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

    it "returns an error message if required inputs are missing" do
      body = {
          subscription: {
            frequency: 30,
            ounces: 2
          }
      }

      post "/api/v1/subscriptions", params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      subscription_info = JSON.parse(response.body, symbolize_names: true)

      expect(subscription_info[:error]).to eq('Please provide the required inputs')
    end
  end

  describe "PATCH" do
    it "can cancel a customer's tea subscription" do
      body = {
          subscription: {
            status: 'cancelled'
          }
      }

      patch "/api/v1/subscriptions/#{@subscription_1.id}", params: body, as: :json

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
      expect(subscription_info[:data][:attributes][:status]).to eq('cancelled')
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

    it 'returns an error if the status does not change' do
      @subscription_1.cancelled!

      body = {
          subscription: {
            status: 'cancelled'
          }
      }

      patch "/api/v1/subscriptions/#{@subscription_1.id}", params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      subscription_info = JSON.parse(response.body, symbolize_names: true)

      expect(subscription_info).to have_key(:error)
      expect(subscription_info[:error]).to eq('This subscription currently has the requested status. No change made.')
    end

    it 'returns an error if the subscription does not exist' do
      body = {
          subscription: {
            status: 'cancelled'
          }
      }

      patch "/api/v1/subscriptions/30000", params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      subscription_info = JSON.parse(response.body, symbolize_names: true)

      expect(subscription_info).to have_key(:error)
      expect(subscription_info[:error]).to eq('The subscription does not exist')
    end
  end

  describe 'INDEX' do
    it "returns all of a customer's tea subscriptions" do
      get "/api/v1/subscriptions?customer_id=#{@customer_1.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(subscriptions).to have_key(:data)
      expect(subscriptions[:data]).to be_an(Array)
      expect(subscriptions[:data].count).to eq(2)
      expect(subscriptions[:data][0]).to be_a(Hash)
      expect(subscriptions[:data][0].keys.count).to eq(3)
      expect(subscriptions[:data][0]).to have_key(:id)
      expect(subscriptions[:data][0][:id]).to be_a(String)
      expect(subscriptions[:data][0]).to have_key(:type)
      expect(subscriptions[:data][0][:type]).to eq("subscription")
      expect(subscriptions[:data][0]).to have_key(:attributes)
      expect(subscriptions[:data][0][:attributes]).to be_a(Hash)
      expect(subscriptions[:data][0][:attributes].keys.count).to eq(7)
      expect(subscriptions[:data][0][:attributes]).to have_key(:price)
      expect(subscriptions[:data][0][:attributes][:price]).to be_an(Integer)
      expect(subscriptions[:data][0][:attributes]).to have_key(:status)
      expect(subscriptions[:data][0][:attributes][:status]).to eq('active')
      expect(subscriptions[:data][0][:attributes]).to have_key(:frequency)
      expect(subscriptions[:data][0][:attributes][:frequency]).to be_an(Integer)
      expect(subscriptions[:data][0][:attributes]).to have_key(:ounces)
      expect(subscriptions[:data][0][:attributes][:ounces]).to be_an(Integer)
      expect(subscriptions[:data][0][:attributes]).to have_key(:customer_id)
      expect(subscriptions[:data][0][:attributes][:customer_id]).to eq(@customer_1.id)
      expect(subscriptions[:data][0][:attributes]).to have_key(:tea_id)
      expect(subscriptions[:data][0][:attributes][:tea_id]).to eq(@tea_1.id)
      expect(subscriptions[:data][0][:attributes]).to have_key(:address_id)
      expect(subscriptions[:data][0][:attributes][:address_id]).to eq(@address_1.id)
    end

    it "returns an error message if the customer does not exist" do
      get "/api/v1/subscriptions?customer_id=30000"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(subscriptions[:error]).to eq('The customer does not exist')
    end
  end
end
