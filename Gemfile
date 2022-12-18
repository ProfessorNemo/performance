# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'active_model_serializers', '~> 0.10.13'
gem 'bcrypt', '~> 3.1'
gem 'faraday', '~> 2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'raddocs'
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug'
  gem 'dotenv', '~> 2.7'
  gem 'dotenv-rails', '~> 2.7'
  gem 'factory_bot_rails'
  gem 'listen', '~> 3.3'
  gem 'rspec_api_documentation'
  gem 'rspec-rails'
  gem 'rubocop', '~> 1.3', require: false
  gem 'rubocop-performance', '~> 1.1', require: false
  gem 'rubocop-rails', '~> 2.1', require: false
  gem 'shoulda-matchers'
  gem 'vcr', '~> 6.1'
  gem 'webmock', '~> 3.1'
end

