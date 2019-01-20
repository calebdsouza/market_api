class Cart < ApplicationRecord
  belongs_to :user, validate: true
  validates :total_price, presence: true
  validates :product_count, presence: true
  has_and_belongs_to_many :products, presence: true
end
