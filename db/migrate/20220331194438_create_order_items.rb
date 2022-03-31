class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :price_at_purchase
      t.integer :amount
      t.string :production_status

      t.timestamps
    end
  end
end
