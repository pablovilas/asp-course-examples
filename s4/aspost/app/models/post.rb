class Post < ApplicationRecord
    # title, content, date
    belongs_to :user
    has_many :comments
end
