require 'rails_helper'

RSpec.describe ViewParty, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :duration}
    it {should validate_presence_of :date}
    it {should validate_numericality_of :duration}
  end

  describe 'Relationships' do
    it {should belong_to :host}
    it {should have_many :view_party_attendees}
    it {should have_many(:users).through(:view_party_attendees)}
    it {should belong_to :movie}
  end
end
