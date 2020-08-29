class AddOrganizationToIncident < ActiveRecord::Migration[6.0]
  def change
    add_reference :incidents, :organization, null: true, foreign_key: true
  end
end
