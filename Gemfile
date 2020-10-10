source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'activerecord-session_store'
gem 'aws-sdk-s3'
gem 'bcrypt'
gem 'bootsnap', require: false
gem 'pg'
gem 'puma'
gem 'rails'
gem 'sass-rails'
gem 'sidekiq'
gem 'turbolinks'
gem 'webpacker'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'colorize'
  gem 'rubocop-rails'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'capybara'
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'guard-rspec'
  gem 'rspec-rails'
  gem 'rubocop-rspec'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :development, :test do
  gem 'rubocop'
end
