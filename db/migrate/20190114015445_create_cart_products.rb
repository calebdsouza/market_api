class CreateCartsProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts_products do |t|
      t.belongs_to :product, index: true
      t.belong_to :cart, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
