class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.references :mission, foreign_key: true
      t.string :title
      t.string :status

      t.timestamps
    end
  end
end
