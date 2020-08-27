require 'rails_helper'

RSpec.describe "User can Logout" do
  before :each do
    OmniAuth.config.mock_auth[:google_oauth2]
    visit '/'
    click_on 'Login with Google'
  end

  it 'welcome page has logout when logged in'  do
    visit '/'

    expect(page).to have_button('Logout')
    expect(page).to_not have_link('Login with Google')
  end

  it 'logs out the user' do
    visit '/'

    click_on 'Logout'

    expect(current_path).to eq('/')
    expect(page).to have_content('User Logged out successfully')
    expect(page).to_not have_button('Logout')
    expect(page).to have_link('Login with Google')

  end

  it 'has a logout link in discover page' do
    visit discover_path

    expect(page).to have_link('Logout')

    click_on 'Logout'

    expect(current_path).to eq('/')
    expect(page).to have_link('Login with Google')
  end
end
