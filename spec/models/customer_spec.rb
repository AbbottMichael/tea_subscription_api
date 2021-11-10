require 'rails_helper'

RSpec.describe Customer do
  describe 'associations' do
    it { should have_many(:addresses).dependent(:destroy) }
    it { should have_many(:subscriptions).dependent(:destroy) }
  end
end
