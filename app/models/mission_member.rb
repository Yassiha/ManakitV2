class MissionMember < ApplicationRecord
  belongs_to :mission
  belongs_to :user
end
