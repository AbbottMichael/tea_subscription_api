require 'rails_helper'

RSpec.describe Address do
  describe 'associations' do
    it { should belong_to(:customer) }
    it { should have_many(:subscriptions) }
  end
end
