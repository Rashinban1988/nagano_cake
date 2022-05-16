class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|

      t.integer :price_at_purchase
      t.integer :amount
      t.string :production_status
      t.references :item, foreign_key: true, :null => false
      t.references :order, foreign_key: true, :null => false

      t.timestamps
    end
  end
end
