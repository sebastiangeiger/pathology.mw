source 'https://rubygems.org'

gem 'rails', '~> 4.1.10'

# Database
gem 'pg', '~> 0.17.1'

# Authentication and authorization
gem 'devise', '~> 3.2.4'
gem 'cancancan', '~> 1.9.1'

# Views
gem 'jquery-rails', '~> 3.1.1'
gem 'turbolinks', '~> 2.2.2'
gem 'slim-rails', '~> 2.1.5'
gem 'zurb-foundation', '~> 4.3.2'
gem 'foundation_rails_helper'
gem 'sass'

# Assets
gem 'uglifier'
gem 'quiet_assets'

# Heroku
gem 'rails_12factor'

# Pagination
gem 'kaminari'

# Searching
gem 'pg_search'

group :development do
  gem 'sqlite3', '~> 1.3.9'
  gem 'launchy'
  gem 'meta_request'
  gem 'rack-livereload'
  gem 'guard-livereload', require: false
  gem 'travis', '~> 1.7.0'
  gem 'mechanize'
end

group :test, :development do
  gem 'pry'
  gem 'rspec-rails', '~> 3.0.2'
end

group :test do
  gem 'cucumber-rails', '~> 1.4.1', require: false
  gem 'database_cleaner', '~> 1.3.0'
  gem 'factory_girl_rails'
  gem 'poltergeist'
  gem 'timecop'
  gem 'codeclimate-test-reporter', require: false
  gem 'rubocop', '~> 0.29.1'
end
