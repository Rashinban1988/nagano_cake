class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|

      t.integer :amount
      t.references :customer, foreign_key: true, :null => false
      t.references :item, foreign_key: true, :null => false

      t.timestamps
    end
  end
end
