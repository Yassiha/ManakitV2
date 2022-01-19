class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :mission, foreign_key: true
      t.date :start_date
      t.date :due_date
      t.string :title
      t.text :description
      t.string :status
      t.string :priority

      t.timestamps
    end
  end
end
