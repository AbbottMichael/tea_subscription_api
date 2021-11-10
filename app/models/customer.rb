class Customer < ApplicationRecord
  has_many :addresses
  has_many :subscriptions
end
