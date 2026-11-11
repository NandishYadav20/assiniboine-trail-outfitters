class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.string :sku
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.integer :stock_quantity
      t.boolean :active
      t.timestamps
    end
    add_index :products, :sku, unique: true
  end
end
