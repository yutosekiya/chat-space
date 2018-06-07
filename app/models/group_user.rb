class GroupUser < ApplicationRecord
  belongs_to :user
  belogs_to :group
end
