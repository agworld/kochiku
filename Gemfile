source 'https://rubygems.org'

gem 'rails', '3.2.14'
gem 'passenger', '4.0.16', group: :production

gem 'carrierwave'
gem 'pg'
gem 'symbolize'

gem 'haml-rails'
gem 'sass'
gem 'compass'

gem 'resque'
gem 'resque-retry'
gem 'json' # used by resque

gem 'chunky_png'
gem 'cocaine'
gem 'awesome_print', require: false
gem 'nokogiri'
gem 'httparty'

gem 'bullet'
gem 'pry-rails'

gem "configatron"

group :assets do
  gem 'compass-rails'
  gem 'jquery-rails'
  gem 'sass-rails'
  gem 'uglifier'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'launchy'
end

group :development do
  gem 'capistrano', require: false
  gem 'quiet_assets'
  gem 'rvm-capistrano', require: false
  gem 'thin'
  gem 'rails-erd'
  gem "byebug"
end

group :test do
  gem 'webmock', require: false
  gem 'capybara'
end
