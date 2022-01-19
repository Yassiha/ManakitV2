class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_many :messages
  has_many :project_members
  has_many :projects, through: :project_members
  has_many :mission_members
  has_many :missions, through: :missions_members
  has_many :task_members
  has_many :users, through: :task_members
  has_many :managing_projects, inverse_of: "manager", class_name: "Project", dependent: :destroy
end
