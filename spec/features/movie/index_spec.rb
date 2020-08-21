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
end
