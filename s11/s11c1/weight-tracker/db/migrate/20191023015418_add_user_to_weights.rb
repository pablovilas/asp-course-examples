class AddUserToWeights < ActiveRecord::Migration[6.0]
  def change
    add_reference :weights, :user, null: true, foreign_key: true
  end
end
