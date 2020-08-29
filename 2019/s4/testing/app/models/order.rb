class Order < ApplicationRecord
    # date total
    has_many :order_line
    has_one :customer
end
