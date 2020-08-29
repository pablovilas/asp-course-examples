class CreateWeights < ActiveRecord::Migration[6.0]
  def change
    create_table :weights do |t|
      t.integer :value
      t.date :sample_date

      t.timestamps
    end
  end
end
