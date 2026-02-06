class AddScoreToObservations < ActiveRecord::Migration[8.1]
  def change
    add_column :observations, :score, :integer
  end
end
