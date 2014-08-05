source "https://rubygems.org"

gem 'rails', '~> 4.1.4'

#Database
gem 'pg', '~> 0.17.1'

#Authentication and authorization
gem 'devise', '~> 3.2.4'
gem 'cancancan', '~> 1.9.1'

#Views
gem 'jquery-rails', '~> 3.1.1'
gem 'turbolinks', '~> 2.2.2'
gem 'slim', '~> 2.0.3'
gem 'zurb-foundation', '~> 4.3.2'
gem 'foundation_rails_helper'
gem 'sass'

#Assets
gem 'uglifier'

#Heroku
gem 'rails_12factor'

group :development do
  gem 'sqlite3', '~> 1.3.9'
  gem 'launchy'
  gem 'meta_request'
  gem 'rack-livereload'
  gem 'guard-livereload', require: false
  gem 'travis', '~> 1.6.17'
  gem 'pry'
  gem 'mechanize'
end

group :test, :development do
  gem 'rspec-rails', '~> 3.0.2'
end

group :test do
  gem 'cucumber-rails', '~> 1.4.1', require: false
  gem 'database_cleaner', '~> 1.3.0'
  gem 'factory_girl_rails'
  gem 'poltergeist'
end

