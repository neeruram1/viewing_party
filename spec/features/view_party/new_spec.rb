require 'rails_helper'

RSpec.describe 'Create Party', :vcr do

  it 'has a form' do
    visit new_view_party_path

    find_field :duration
    find_field :date

    find_button 'Create Party'
  end

  it 'has details', :vcr do
    movie = MovieResult.new(MovieData.all_movie_att('299536'))
    visit "/movies/#{movie.id}"

    click_on 'Add Viewing Party for Movie'

    expect(current_path).to eq(new_view_party_path)

    expect(page).to have_content('Avengers: Infinity War')
    expect(find_field(:duration).value).to eq('149')
  end
  
end
