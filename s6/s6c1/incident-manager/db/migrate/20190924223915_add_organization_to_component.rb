class AddOrganizationToComponent < ActiveRecord::Migration[6.0]
  def change
    add_reference :components, :organization, null: true, foreign_key: true
  end
end
