class AddPriceProductCountToCart < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :total_price, :decimal
    add_column :carts, :product_count, :integer
  end
end
