class Product < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validates :price, presence: true
    validates :inventory_count, presence: true
end
