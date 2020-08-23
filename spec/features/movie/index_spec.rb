require 'rails_helper'

RSpec.describe 'Movies index page' do

  it "I see 40 results of my search", :vcr do
    visit '/discover'

    fill_in :search, with: "Avengers"
    click_button 'Find Movies'

    expect(current_path).to eq('/movies')

    expect(page).to have_content("Avengers: Infinity War")
    expect(page).to have_content("Vote Average: 8.3")

    expect(page).to have_content("The Avengers")
    expect(page).to have_content("Vote Average: 10")
  end

  it "I see the first 40 top rated movies", :vcr do
    visit '/movies'
    click_on 'Find Top Rated Movies'

    expect(page).to have_content("Gabriel's Inferno Part II")
    expect(page).to have_content("Vote Average: 9.1")
    expect(page).to_not have_content("Avengers: Infinity War")
  end

  it "A movie title links to the movie show page", :vcr do
    id = 299536
    visit '/movies'

    fill_in :search, with: "Avengers"
    click_button 'Find Movies'

    click_on "Avengers: Infinity War"

    expect(current_path).to eq("/movies/#{id}")
  end
end
