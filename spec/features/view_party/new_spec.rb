require 'rails_helper'

RSpec.describe 'Create Party' do
  before :each do
    OmniAuth.config.mock_auth[:google_oauth2]
    visit '/'
    click_on 'Login with Google'
    @user = User.last
  end

  it 'has a form', :vcr do
    visit new_view_party_path

    find_field :duration
    find_field :date

    find_button 'Create Party'
  end

  it "If I don't have any friends to add I see a message", :vcr do
    visit new_view_party_path
    expect(page).to have_content("You currently have no friends")
  end

  it 'has details', :vcr do
    friend = User.create(uid: "111111", name: "Neeru Ram", email: "neeru@turing.io")
    Friendship.create(user: @user, friend: friend)

    id = 299536
    search = SearchResults.new
    movie = search.movie_details(id)

    visit "/movies/#{movie.id}"

    click_on 'Add Viewing Party for Movie'

    expect(current_path).to eq("/view_party/new")

    expect(page).to have_content('Avengers: Infinity War')
    expect(find_field(:duration).value).to eq('149')

    expect(page).to have_content(friend.name)
  end
end
