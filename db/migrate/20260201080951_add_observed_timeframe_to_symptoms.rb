class AddObservedTimeframeToSymptoms < ActiveRecord::Migration[8.1]
  def change
    add_column :symptoms, :observed_from, :timestamp
    add_column :symptoms, :observed_to, :timestamp
  end
end
