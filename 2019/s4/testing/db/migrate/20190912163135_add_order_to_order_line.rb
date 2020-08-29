class AddOrderToOrderLine < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_lines, :order, null: true, foreign_key: true
  end
end
