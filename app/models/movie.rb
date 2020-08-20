class Movie < ApplicationRecord
  validates :name, presence: true
  validates :duration, presence: true
  belongs_to :view_party
end
