# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'active_model_serializers', '~> 0.10.13'
gem 'pg', '~> 1.1'
gem 'puma', '~> 6.0'
gem 'raddocs'
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'rspec_api_documentation'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rubocop', '~> 1.3', require: false
  gem 'rubocop-performance', '~> 1.1', require: false
  gem 'rubocop-rails', '~> 2.1', require: false
end
