require 'rails_helper'

RSpec.describe 'Discover Page' do
  before :each do
    visit '/discover'
  end

  it "I see a button to discover top-rated movies" do
    expect(page).to have_link('Find Top Rated Movies')
  end

  it "I see a text field to enter a keyword(s) to search by movie title", :vcr do
    fill_in :search, with: 'Avengers'
    click_on 'Find Movie'
    expect(current_path).to eq('/movies')
  end

  it 'I see to 20 rated movies', :vcr do
    click_on 'Find Top Rated Movies'

    expect(current_path).to eq('/movies')
    within '.top-rated' do
      expect(page).to have_link('Gabriel\'s Inferno Part II')
      expect(page).to have_link('Gabriel\'s Inferno')
      expect(page).to have_link('Dilwale Dulhania Le Jayenge')
    end
  end
end
