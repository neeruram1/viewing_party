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

  it "I see a viewing parties section" do
    within '.viewing-parties' do
      expect(page).to have_content('Viewing Parties')
    end
  end
end
