class CreateIncidents < ActiveRecord::Migration[6.0]
  def change
    create_table :incidents do |t|
      t.string :name
      t.string :status
      t.string :message

      t.timestamps
    end
  end
end
