class CreateProvinces < ActiveRecord::Migration[7.2]
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :code
      t.decimal :gst, precision: 6, scale: 5
      t.decimal :pst, precision: 6, scale: 5
      t.decimal :hst, precision: 6, scale: 5
      t.timestamps
    end
  end
end
