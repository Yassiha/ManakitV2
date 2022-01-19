class Topic < ApplicationRecord
  belongs_to :mission
  has_many :messages, dependent: :destroy
end
