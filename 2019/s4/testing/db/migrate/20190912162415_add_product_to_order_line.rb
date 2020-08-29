class AddProductToOrderLine < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_lines, :product, null: true, foreign_key: true
  end
end
