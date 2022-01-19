class Task < ApplicationRecord
  belongs_to :mission
  has_many :task_members
  has_many :users, through: :task_members
end
