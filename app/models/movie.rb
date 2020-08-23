class Movie < ApplicationRecord
  validates :name, presence: true
  validates :duration, presence: true
  validates :api_id, presence: true
  has_many :view_parties
end
