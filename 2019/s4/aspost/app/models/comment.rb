class Comment < ApplicationRecord
    # text, date
    belongs_to :user
    belongs_to :post
end
