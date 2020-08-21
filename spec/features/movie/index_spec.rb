require 'rails_helper'

RSpec.describe 'Movies index page' do
  before :each do
    visit '/movies'
  end

  it "I see the top rated movies button" do
    expect(page).to have_link('Find Top Rated Movies')
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
      expect(page).to have_content("Avengers: Infinity War")
      expect(page).to have_content("Vote Average: 8.3")
    end
  end

  it 'should show a message to the user', :vcr do
    fill_in :search, with: 'qqwertyuiop[sdfghj'
    click_on 'Find Movie'
    expect(current_path).to eq('/movies')

    within '.search-results' do
      expect(page).to have_content("There was no match to the movie entered.")
    end

  end
end
