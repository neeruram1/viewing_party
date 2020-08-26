require 'rails_helper'

RSpec.describe 'User dashboard page' do
  before :each do
    OmniAuth.config.mock_auth[:google_oauth2]
    visit '/'
    click_on 'Login with Google'
    @user = User.last
  end

  it 'returns an error page if not logged in ' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
    visit dashboard_path

    expect(page).to have_content("You are not authorized to access this page")
    expect(page).to have_content('401')
  end

  it "I see a welcome message" do
    user = User.create({name: 'John Doe', email: 'john@turing.io', uid: '9876543210'})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("Welcome #{user.name}!")
  end

  it "I see a button to Discover Movies" do
    expect(page).to have_button("Discover Movies")

    click_on "Discover Movies"

    expect(current_path).to eq("/discover")
  end

  it "I see a friends section" do
    within '.friends' do
      expect(page).to have_content('Friends')
    end
  end

  it "I can add a friend" do
    neeru = User.create(uid: "111111", email: "neeru@turing.io")

    within '.friends' do
      fill_in :email, with: neeru.email
      click_on 'Add Friend'
    end

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Friend successfully added")

    within '.friends' do
      expect(page).to have_content('My Friends')
      expect(page).to have_content(neeru.email)
    end
  end

  it "I see a message saying I have no friends if I haven't added any" do
    within '.friends' do
      expect(page).to have_content('You currently have no friends')
    end
  end

  it "I can't add a friend if they are not in the system" do
    within '.friends' do
      fill_in :email, with: 'idontexit@turing.io'
      click_on 'Add Friend'
    end

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Friend must exist")
  end

  it "I can only add a friend once" do
    neeru = User.create(uid: "111111", email: "neeru@turing.io")

    within '.friends' do
      fill_in :email, with: neeru.email
      click_on 'Add Friend'
    end

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Friend successfully added")

    within '.friends' do
      fill_in :email, with: neeru.email
      click_on 'Add Friend'
    end

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('This friend has already been added')
  end

  it "I see a viewing parties section" do
    within '.viewing-parties' do
      expect(page).to have_content('Viewing Parties')
    end
  end

  it 'I can see parties I am attending and hosting', :vcr do
    friend = User.create(uid: "111111", email: "neeru@turing.io")
    Friendship.create(user: @user, friend: friend)

    id = 299536
    search = SearchResults.new
    movie_result = search.movie_details(id)

    movie = Movie.create(name: movie_result.title, duration: movie_result.runtime, api_id: id)
    party = ViewParty.create(duration: movie.duration, date: "10/20/2020", host: @user, movie: movie)
    ViewPartyAttendee.create(user: friend, view_party: party)

    party2 = ViewParty.create(duration: movie.duration, date: "10/25/2020", host: friend, movie: movie)
    ViewPartyAttendee.create(user: @user, view_party: party2)

    visit '/dashboard'

    expect(page).to have_content(party.movie.name)
    expect(page).to have_content(party2.date)
    expect(page).to_not have_content('You have no viewing parties!')
  end

  it "I can add the viewing parties that I am attending to my google calendar", :vcr do
    friend = User.create(uid: "111111", email: "neeru@turing.io")
    Friendship.create(user: @user, friend: friend)

    id = 299536
    search = SearchResults.new
    movie_result = search.movie_details(id)

    movie = Movie.create(name: movie_result.title, duration: movie_result.runtime, api_id: id)
    party = ViewParty.create(duration: movie.duration, date: "10/20/2020", host: friend, movie: movie)
    ViewPartyAttendee.create(user: @user, view_party: party)

    movie2 = Movie.create(name: 'Lord of the Rings: Return of the King', duration: "112", api_id: 234535)
    party2 = ViewParty.create(duration: movie2.duration, date: "10/20/2020", host: @user, movie: movie2)
    ViewPartyAttendee.create(user: friend, view_party: party2)

    visit '/dashboard'

    expect(page).to have_button('Add to my Google Calendar')
  end

  it 'I cannot add myself as a friend' do
    within '.friends' do
      fill_in :email, with: @user.email
      click_on 'Add Friend'
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Friend cannot refer back to yourself")

    within ".friends" do
      expect(page).to have_content("You currently have no friends")
    end
  end
end
