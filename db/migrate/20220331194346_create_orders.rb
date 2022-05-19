class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :shipping_postal_code
      t.string :shipping_address
      t.string :shipping_name
      t.integer :postage
      t.integer :claimed
      t.integer :amount_billed, default: 0, null: false, limit: 1
      t.integer :order_status, default: 0, null: false, limit: 4
      t.integer :cart_items_id
      t.references :customer, foreign_key: true, :null => false


      t.timestamps
    end
  end
end
