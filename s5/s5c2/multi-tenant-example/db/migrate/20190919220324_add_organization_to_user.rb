class AddOrganizationToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :organization, null: true, foreign_key: true
  end
end
