class CreateProblems < ActiveRecord::Migration[8.1]
  def change
    create_table :problems do |t|
      t.string :name
      t.text :details

      t.timestamps
    end
  end
end
