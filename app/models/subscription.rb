class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :address
  belongs_to :tea
end
