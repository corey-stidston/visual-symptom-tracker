class AddObservationToSymptoms < ActiveRecord::Migration[8.1]
  def change
    add_column :symptoms, :observation, :text
  end
end
