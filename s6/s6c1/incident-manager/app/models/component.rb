class Component < ApplicationRecord
    belongs_to :organization
    has_and_belongs_to_many :subscribers
    has_and_belongs_to_many :incidents
end
