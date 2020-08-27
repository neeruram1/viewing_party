require 'rails_helper'


RSpec.describe 'Discover Page' do

  it 'returns an error page if not logged in ' do
    visit dashboard_path

    expect(page).to have_content("You are not authorized to access this page")
    expect(page).to have_content('401')
  end

  xit "I see a button to discover top-rated movies", :vcr do
    user = User.create({name: 'John Doe', email: 'john@gmail.com', uid: '9876543210'})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/discover'

    expect(page).to have_link('Find Top Rated Movies')
    click_on 'Find Top Rated Movies'
    expect(current_path).to eq('/discover')
  end

  xit "I see a form to search by movie keyword", :vcr do
    user = User.create({name: 'John Doe', email: 'john@gmail.com', uid: '9876543210'})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/discover'

    fill_in "Search by movie title", with: "Avengers"
    click_button 'Find Movies'

    expect(current_path).to eq('/discover')
  end

  xit "I see 40 results of my search", :vcr do
    visit '/discover'

    fill_in "Search by movie title", with: "Avengers"
    click_button 'Find Movies'

    expect(current_path).to eq('/discover')

    expect(page).to have_content("Avengers: Infinity War")
    expect(page).to have_content("Vote Average: 8.3")

    expect(page).to have_content("The Avengers")
    expect(page).to have_content("Vote Average: 10")
  end

  xit "I see the first 40 top rated movies", :vcr do
    visit '/discover'
    click_on 'Find Top Rated Movies'

    expect(page).to have_content("Gabriel's Inferno Part II")
    expect(page).to have_content("Vote Average: 9.1")
    expect(page).to_not have_content("Avengers: Infinity War")
  end

  xit "A movie title links to the movie show page", :vcr do
    id = 299536
    visit '/discover'

    fill_in "Search by movie title", with: "Avengers"
    click_button 'Find Movies'

    click_on "Avengers: Infinity War"

    expect(current_path).to eq("/movies/#{id}", wait: 3)
  end

  xit "I see an message if there are no search results", :vcr do
    visit '/discover'

    fill_in "Search by movie title", with: "alksjdfl;kajsdf;lkajsdf;l"
    click_button 'Find Movies'
    expect(page).to have_content("No movies found with that keyword.")
  end
end
