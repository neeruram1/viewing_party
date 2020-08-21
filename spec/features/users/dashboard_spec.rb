require 'rails_helper'

RSpec.describe 'User dashboard page' do
  before :each do
    OmniAuth.config.mock_auth[:google_oauth2]
    visit '/'
    click_on 'Login with Google'
    @user = User.last
  end

  it "I see a welcome message" do
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Welcome #{@user.name}!")
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
    neeru = User.create(uid: "111111", name: "Neeru Ram", email: "neeru@turing.io")

    within '.friends' do
      fill_in :email, with: neeru.email
      click_on 'Add Friend'
    end

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Friend successfully added")

    within '.friends' do
      expect(page).to have_content('My Friends')
      expect(page).to have_content(neeru.name)
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
    neeru = User.create(uid: "111111", name: "Neeru Ram", email: "neeru@turing.io")

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
end
