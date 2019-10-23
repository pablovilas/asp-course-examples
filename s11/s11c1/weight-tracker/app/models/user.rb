class User < ApplicationRecord
    def average_weight
        Weight.where(user: self).average(:value)
    end
end
