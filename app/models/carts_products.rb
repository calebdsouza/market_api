class CartsProducts < ApplicationRecord
  belongs_to :cart, validate: true
  belongs_to :product, validate: true
end
