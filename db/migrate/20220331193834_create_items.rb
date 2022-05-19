class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :introduction
      t.integer :price
      t.boolean :is_active, default: true
      t.references :genre, foreign_key: true, :null => false
      t.timestamps
    end
  end
end
