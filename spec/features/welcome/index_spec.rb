require 'rails_helper'

RSpec.describe "Welcome path" do

  it "Displays a brief description of the application" do
    visit '/'

    expect(page).to have_content("Welcome To The Viewing Party!")
    expect(page).to have_content("Set up watch parties for your favorite movies with all your friends!")
  end

  it "has a button to login with google" do
    OmniAuth.config.mock_auth[:google_oauth2]

    visit '/'
    expect(page).to  have_link("Login with Google")
    click_on "Login with Google"

    expect(current_path).to  eq('/dashboard')
  end
end
