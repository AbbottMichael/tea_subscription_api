class Customer < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
end
