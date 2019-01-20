class Product < ApplicationRecord
    validates :title, presence: true, uniqueness: true, length: {minimum: 3}
    validates :price, presence: true
    validates :inventory_count, presence: true
    has_and_belongs_to_many :carts
end
