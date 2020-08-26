require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :email}
    it {should validate_presence_of :uid}
  end

  describe 'Relationships' do
    it {should have_many(:view_parties).through(:view_party_attendees)}
    it {should have_many :view_party_attendees}
    it {should have_many :view_parties}
    it {should have_many(:friends).through(:friendships)}
    it {should have_many(:friendships)}
  end

  describe 'Methods', :vcr do
    it "parties_hosting" do

      host = User.create(uid: "111111", name: "Neeru Ram", email: "neeru@turing.io")
      friend = User.create(uid: "11134211", name: "Kwibe", email: "kwibe@turing.io")
      Friendship.create(user: host, friend: friend)

      id = 299536
      search = SearchResults.new
      movie_result = search.movie_details(id)

      movie = Movie.create(name: movie_result.title, duration: movie_result.runtime, api_id: id)
      party = ViewParty.create(duration: movie.duration, date: "10/20/2020", host: host, movie: movie)
      ViewPartyAttendee.create(user: friend, view_party: party)

      party2 = ViewParty.create(duration: movie.duration, date: "10/20/2020", host: friend, movie: movie)
      ViewPartyAttendee.create(user: host, view_party: party2)

      expect(host.parties_hosting).to eq([party])
    end

    it "all_parties" do
      host = User.create(uid: "111111", name: "Neeru Ram", email: "neeru@turing.io")
      friend = User.create(uid: "11134211", name: "Kwibe", email: "kwibe@turing.io")
      Friendship.create(user: host, friend: friend)

      id = 299536
      search = SearchResults.new
      movie_result = search.movie_details(id)

      movie = Movie.create(name: movie_result.title, duration: movie_result.runtime, api_id: id)
      party = ViewParty.create(duration: movie.duration, date: "10/20/2020", host: host, movie: movie)
      ViewPartyAttendee.create(user: friend, view_party: party)

      party2 = ViewParty.create(duration: movie.duration, date: "10/20/2020", host: friend, movie: movie)
      ViewPartyAttendee.create(user: host, view_party: party2)

      expect(host.all_parties).to eq([party, party2])
    end
  end
end
