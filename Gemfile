source 'https://rubygems.org'

git_source(:github) do |repo_name|
   repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.3'

gem 'rails', '5.2.4.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'bootsnap'
gem 'jbuilder', '~> 2.5'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'faraday', '~> 1.0', '>= 1.0.1'
gem 'omniauth-google-oauth2', '~> 0.8.0'
gem 'chronic'
gem 'google-api-client', require: 'google/apis/calendar_v3'

group :development, :test do
  gem 'pry'
  gem 'travis'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop-rails'
  gem 'travis'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'simplecov'
  gem 'webmock'
  gem 'vcr'
  gem 'shoulda-matchers'
  gem 'simplecov'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
