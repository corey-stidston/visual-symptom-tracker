class AddProblemRefToObservations < ActiveRecord::Migration[8.1]
  def change
    add_reference :observations, :problem, null: false, foreign_key: true
  end
end
