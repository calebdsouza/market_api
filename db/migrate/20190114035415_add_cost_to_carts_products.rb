class AddCostToCartsProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts_products, :cost, :decimal
  end
end
