source 'http://rubygems.org'

# gem 'rails', '3.1.0.rc6'

# Bundle edge Rails instead:
gem 'rails', '~> 3.1.0'

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'capistrano-ext'

# Mongoid
gem "mongoid", "~> 2.2"
gem 'bson_ext'

gem 'nokogiri', :require => 'nokogiri'
gem 'haml-rails'
gem 'airbrake'

group :assets do
  gem 'sass-rails', '~> 3.1.0'
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier'
end

group :development do
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'pry'
end

group :staging do
  gem 'unicorn'
end

group :production do
  gem 'unicorn'
end
