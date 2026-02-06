class CreateObservations < ActiveRecord::Migration[8.1]
  def change
    create_table :observations do |t|
      t.string :name
      t.timestamp :observed

      t.timestamps
    end
  end
end
