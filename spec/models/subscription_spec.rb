require 'rails_helper'

RSpec.describe Subscription do
  describe 'Relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:address) }
    it { should belong_to(:tea) }
  end
end