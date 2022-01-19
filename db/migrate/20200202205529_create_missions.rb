class CreateMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|
      t.references :project, foreign_key: true
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
