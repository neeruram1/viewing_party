require 'rails_helper'

RSpec.describe 'Discover Page' do
  before :each do
    visit '/discover'
  end

  it "I see a button to discover top-rated movies", :vcr do
    expect(page).to have_link('Find Top Rated Movies')
    click_on 'Find Top Rated Movies'
    expect(current_path).to eq('/movies')
  end

  it "I see a form to search by movie keyword", :vcr do

    fill_in :search, with: "Avengers"
    click_button 'Find Movies'

    expect(current_path).to eq('/movies')
  end
end
