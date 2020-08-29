class OrderLine < ApplicationRecord
    # quantity, subtotal
    belongs_to :order
    has_one :product
end
