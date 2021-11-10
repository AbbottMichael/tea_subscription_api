require 'rails_helper'

RSpec.describe Tea do
  describe 'associations' do
    it { should have_many(:subscriptions) }
  end
end
