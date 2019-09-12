class CreateOrderLines < ActiveRecord::Migration[6.0]
  def change
    create_table :order_lines do |t|
      t.integer :quantity
      t.float :subtotal

      t.timestamps
    end
  end
end
