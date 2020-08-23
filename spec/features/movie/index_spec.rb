require 'rails_helper'

RSpec.describe 'Movies index page' do
  before :each do
    visit '/movies'
  end
end
