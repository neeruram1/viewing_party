class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates_uniqueness_of :friend, scope: :user, message: 'This friend has already been added'
  validate :disallow_self_referential_friendship

  def disallow_self_referential_friendship
    if friend_id == user_id
      errors.add(:friend_id, 'Friend cannot refer back to yourself')
    end
  end
end
