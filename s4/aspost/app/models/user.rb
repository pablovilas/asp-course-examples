class User < ApplicationRecord
    # name, email, password

    validates :email, uniqueness: true, presence: true, on: :create
    validates :name, presence: true
    validates :password, presence: true, confirmation: true

    has_many :posts
    has_many :comments
end
