require 'rails_helper'

RSpec.describe 'movie show page' do
  it 'can get to new party page', :vcr do
      res = MovieService.new.movies
      id = res[:results][0][:id]

      visit "/movies/#{id}"

      expect(page).to  have_button('Add Viewing Party for Movie')

      click_on 'Add Viewing Party for Movie'

      expect(current_path).to  eq('/view_party/new')
  end
end