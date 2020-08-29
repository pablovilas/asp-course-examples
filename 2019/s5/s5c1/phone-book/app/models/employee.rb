class Employee < ApplicationRecord
  
  belongs_to :company, touch: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :company, presence: true
  
  def to_s
    “#{first_name} #{last_name}”
  end

end
