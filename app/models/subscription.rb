class Subscription < ApplicationRecord
  enum status: { active: 0, cancelled: 1 }

  belongs_to :customer
  belongs_to :address
  belongs_to :tea

  def calculate_price
    self.tea.price_oz * self.ounces
  end
end
