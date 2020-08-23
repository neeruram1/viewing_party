class ViewParty < ApplicationRecord
  validates :duration, presence: true
  validates :date, presence: true

  belongs_to :host, class_name: 'User'
  has_many :view_party_attendees, dependent: :destroy
  has_many :users, through: :view_party_attendees
  belongs_to :movie
end
