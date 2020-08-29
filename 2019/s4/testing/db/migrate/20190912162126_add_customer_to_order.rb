class AddCustomerToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :customer, null: true, foreign_key: true
  end
end
