require 'rails_helper'

RSpec.describe 'Discover Page' do
  before :each do
    visit '/discover'
  end

  it "I see a button to discover top-rated movies" do
    expect(page).to have_button('Find Top Rated Movies')
  end

  it "I see a text field to enter a keyword(s) to search by movie title" do
    fill_in :search, with: 'Avengers'
    click_on 'Find Movie'
    expect(current_path).to eq('/movies')
  end
end
