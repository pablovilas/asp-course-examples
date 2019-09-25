class AddOrganizationToSubscriber < ActiveRecord::Migration[6.0]
  def change
    add_reference :subscribers, :organization, null: true, foreign_key: true
  end
end
