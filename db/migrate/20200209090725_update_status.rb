class UpdateStatus < ActiveRecord::Migration[5.2]
  def change
    remove_column :missions, :status
    remove_column :projects, :status
    remove_column :tasks, :status
    remove_column :topics, :status

    add_column :missions, :status, :integer
    add_column :projects, :status, :integer
    add_column :tasks, :status, :integer
    add_column :topics, :status, :integer
  end
end
