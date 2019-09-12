class Order < ApplicationRecord
    has_many :order_line
    has_one :customer
end
