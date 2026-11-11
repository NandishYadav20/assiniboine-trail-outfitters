class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :province, null: false, foreign_key: true
      t.string :order_number
      t.string :status
      t.decimal :subtotal, precision: 10, scale: 2
      t.decimal :gst_amount, precision: 10, scale: 2
      t.decimal :pst_amount, precision: 10, scale: 2
      t.decimal :hst_amount, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2
      t.timestamps
    end
    add_index :orders, :order_number, unique: true
  end
end
