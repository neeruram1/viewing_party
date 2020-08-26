require 'rails_helper'

RSpec.describe 'Create Party' do
  before :each do
    OmniAuth.config.mock_auth[:google_oauth2]
    visit '/'
    click_on 'Login with Google'
    @user = User.last
  end

  it 'I can create a viewing party', :vcr do
    friend = User.create(uid: "111111", email: "neeru@turing.io")
    Friendship.create(user: @user, friend: friend)
    friend2 = User.create(uid: "11134211", email: "kwibe@turing.io")
    Friendship.create(user: @user, friend: friend2)

    id = 299536
    search = SearchResults.new
    movie = search.movie_details(id)

    visit "/movies/#{movie.id}"

    click_on 'Add Viewing Party for Movie'

    expect(page).to have_content('Avengers: Infinity War')

    expect(page).to have_content(friend.email)
    expect(page).to have_content(friend2.email)

    fill_in :date, with: "10/20/2020"

    check("#{friend.email}")
    check("#{friend2.email}")

    click_on 'Create Party'

    party = ViewParty.last

    expect(current_path).to eq('/dashboard')

    expect(page).to have_content('You have created a new Viewing Party!')
    expect(page).to have_content(party.movie.name)
    expect(page).to_not have_content('You have no viewing parties!')
  end
end
