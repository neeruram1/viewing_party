require 'rails_helper'

RSpec.describe 'movie show page' do
  it 'can get to new party page', :vcr do
      res = MovieService.new.movies
      id = res[:results][0][:id]

      visit "/movies/#{id}"

      expect(page).to have_button('Add Viewing Party for Movie')

      click_on 'Add Viewing Party for Movie'

      expect(current_path).to  eq('/view_party/new')
  end

  it "I see all the information for the movie", :vcr do
    id = 299536
    result = MovieResult.new(MovieData.all_movie_att(id))

    visit "/movies/#{id}"

    expect(page).to have_content(result.title)
    expect(page).to have_content(result.vote_average)
    expect(page).to have_content(result.runtime)
    expect(page).to have_content(result.summary)

    within '.genres' do
      expect(page).to have_content('Genres')
      expect(page).to have_content('Adventure')
      expect(page).to have_content('Action')
      expect(page).to have_content('Science Fiction')
    end

    within '.characters' do
      expect(page).to have_content("Actor/Actress: Robert Downey Jr. Character: Tony Stark / Iron Man")
      expect(page).to have_content("Actor/Actress: Zoe Saldana Character: Gamora")
    end

    within '.reviews' do
      expect(page).to have_content(result.reviews_count)
      expect(page).to have_content("Author:")
    end
  end
end
