class CreateCartsProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts_products do |t|
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
