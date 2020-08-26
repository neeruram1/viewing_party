require 'rails_helper'

RSpec.describe 'Discover Page' do

  it 'returns an error page if not logged in ' do
    visit dashboard_path

    expect(page).to have_content("You are not authorized to access this page")
    expect(page).to have_content('401')
  end

  it "I see a button to discover top-rated movies", :vcr do
    user = User.create({name: 'John Doe', email: 'john@gmail.com', uid: '9876543210'})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/discover'

    expect(page).to have_link('Find Top Rated Movies')
    click_on 'Find Top Rated Movies'
    expect(current_path).to eq('/movies')
  end

  it "I see a form to search by movie keyword", :vcr do
    user = User.create({name: 'John Doe', email: 'john@gmail.com', uid: '9876543210'})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/discover'

    fill_in :search, with: "Avengers"
    click_button 'Find Movies'

    expect(current_path).to eq('/movies')
  end
end
