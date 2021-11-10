require 'rails_helper'

RSpec.describe Customer do
  describe 'Relationships' do
    it { should have_many(:addresses) }
    it { should have_many(:subscriptions) }
  end
end
