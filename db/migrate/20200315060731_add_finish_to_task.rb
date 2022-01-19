class AddFinishToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :finish, :boolean
  end
end
