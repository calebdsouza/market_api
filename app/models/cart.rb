class Cart < ApplicationRecord
  belongs_to :product, validate: true
  belongs_to :user, validate: true
end
