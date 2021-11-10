require 'rails_helper'

RSpec.describe Subscription do
  describe 'associations' do
    it { should belong_to(:customer) }
    it { should belong_to(:address) }
    it { should belong_to(:tea) }
  end

  describe 'instance methods' do
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

    it 'calculates the current price of a subscription' do
      expect(@subscription_1.calculate_price).to eq(800)
    end
  end
end
