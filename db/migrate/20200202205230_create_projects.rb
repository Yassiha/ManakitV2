class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :manager
      t.date :delivery_date
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
