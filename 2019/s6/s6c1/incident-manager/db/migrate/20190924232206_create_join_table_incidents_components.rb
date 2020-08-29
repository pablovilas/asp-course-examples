class CreateJoinTableIncidentsComponents < ActiveRecord::Migration[6.0]
  def change
    create_join_table :incidents, :components do |t|
      # t.index [:incident_id, :component_id]
      # t.index [:component_id, :incident_id]
    end
  end
end
