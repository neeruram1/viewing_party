require 'rails_helper'

RSpec.describe 'Movies index page' do
  before :each do
    visit '/movies'
  end

  it "I see the top rated movies button" do
    expect(page).to have_button('Find Top Rated Movies')
  end

  it "I see the find movies form at the top of the page" do
    expect(page).to have_button('Find Movies')
    find_field(:search)
  end

  it "I can search for a movie and I will see up to 40 results", :vcr do
    fill_in :search, with: 'Avengers'
    click_on 'Find Movie'
    expect(current_path).to eq('/movies')

    within '.search-results' do
      expect(page).to have_content("Title: Avengers: Infinity War")
      expect(page).to have_content("Vote Average: 8.3")
    end
  end
end
