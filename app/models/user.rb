class User < ApplicationRecord
  validates :email, presence: true
  validates :uid, presence: true

  has_many :view_party_attendees, dependent: :destroy
  has_many :view_parties, through: :view_party_attendees
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  def self.update_or_create(user_data)
    user = User.find_by(uid: user_data[:uid]) || User.new
    user.attributes =
      {
        uid: user_data[:uid],
        email: user_data[:email],
        access_token: user_data[:access_token],
        refresh_token: user_data[:refresh_token]
      }
    user.save!
    user
  end

  def parties_hosting
    ViewParty.where(host_id: id)
  end

  def parties_attending
    view_parties
  end

  def all_parties
    parties_hosting + parties_attending
  end
end
