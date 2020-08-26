require 'rails_helper'

RSpec.describe 'Movies index page' do
  before :each do
    user = User.create({name: 'John Doe', email: 'john@gmail.com', uid: '9876543210'})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

  end

  it 'returns an error page if not logged in ' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
    visit movies_path

    expect(page).to have_content("You are not authorized to access this page")
    expect(page).to have_content('401')
  end

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

  it "I see an message if there are no search results", :vcr do
    visit '/movies'

    fill_in :search, with: "alksjdfl;kajsdf;lkajsdf;l"
    click_button 'Find Movies'
    expect(page).to have_content("No movies found with that keyword.")
  end
end
